;;; melody-mode.el --- A major mode for the Melody programming language -*- lexical-binding: t -*-

;; Version: 0.0.1
;; Author: XXIV
;; Keywords: files, melody
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/thechampagne/melody-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for the Melody programming language.

;;;; Installation

;; You can use built-in package manager (package.el) or do everything by your hands.

;;;;; Using package manager

;; Add the following to your Emacs config file

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; Then use `M-x package-install RET melody-mode RET` to install the mode.
;; Use `M-x melody-mode` to change your current mode.

;;;;; Manual

;; Download the mode to your local directory.  You can do it through `git clone` command:

;; git clone git://github.com/thechampagne/melody-mode.git

;; Then add path to melody-mode to load-path list — add the following to your Emacs config file

;; (add-to-list 'load-path
;; 	     "/path/to/melody-mode/")
;; (require 'melody-mode)

;; Use `M-x melody-mode` to change your current mode.

;;; Code:

(defconst melody-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?* ". 23" table)
    (modify-syntax-entry ?\n "> b" table)
    (modify-syntax-entry ?\' "\"" table)
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\` "\"" table)
    table))


(defconst melody-keywords
  '(;; Quantifiers
    "of" "to" "over" "some"
    "any" "option" "lazy"

    ;; Groups
    "capture" "match" "either"

    ;; Assertions
    "ahead" "behind"

    ;; Variables
    "let"

    ;; Others
    "not"))


(defconst melody-symbols
  '("<char>" "<space>" "<whitespace>"
    "<newline>" "<tab>" "<return>"
    "<feed>" "<null>" "<digit>"
    "<vertical>" "<word>"
    "<alphabetic>" "<alphanumeric>"
    "<boundary>" "<backspace>"

    ;; Special Symbols
    "<start>" "<end>"))


(defconst melody-unicode-categories
  '("<category::letter>" "<category::lowercase_letter>"
    "<category::uppercase_letter>" "<category::titlecase_letter>"
    "<category::cased_letter>" "<category::modifier_letter>"
    "<category::other_letter>" "<category::mark>"
    "<category::non_spacing_mark>" "<category::spacing_combining_mark>"
    "<category::enclosing_mark>" "<category::separator>"
    "<category::space_separator>" "<category::line_separator>"
    "<category::paragraph_separator>" "<category::symbol>"
    "<category::math_symbol>" "<category::currency_symbol>"
    "<category::modifier_symbol>" "<category::other_symbol>"
    "<category::number>" "<category::decimal_digit_number>"
    "<category::letter_number>" "<category::other_number>"
    "<category::punctuation>" "<category::dash_punctuation>"
    "<category::open_punctuation>" "<category::close_punctuation>"
    "<category::initial_punctuation>" "<category::final_punctuation>"
    "<category::connector_punctuation>" "<category::other_punctuation>"
    "<category::other>" "<category::control>"
    "<category::format>" "<category::private_use>"
    "<category::surrogate>" "<category::unassigned>"))


(defconst melody-font-lock-keywords
  (list
   `(,(regexp-opt melody-keywords 'symbols) . font-lock-keyword-face)
   `(,(regexp-opt melody-symbols 'symbols) . font-lock-builtin-face)
   `(,(regexp-opt melody-unicode-categories 'symbols) . font-lock-preprocessor-face)))

;;;###autoload
(define-derived-mode melody-mode prog-mode "Melody"
  "A major mode for the Melody programming language."
  :syntax-table melody-mode-syntax-table
  (setq-local font-lock-defaults '(melody-font-lock-keywords))
  (setq-local comment-start "// ")
  (setq-local comment-end ""))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.mdy\\'" . melody-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.melody\\'" . melody-mode))

(provide 'melody-mode)

;;; melody-mode.el ends here
