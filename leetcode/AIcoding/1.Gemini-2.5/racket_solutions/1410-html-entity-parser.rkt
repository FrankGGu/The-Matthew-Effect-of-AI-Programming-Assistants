#lang racket

(define (entity-parser text)
  (let* ((replacements (list
                        (list "&quot;" "\"")
                        (list "&apos;" "'")
                        (list "&amp;" "&")
                        (list "&gt;" ">")
                        (list "&lt;" "<")
                        (list "&frasl;" "/")))
         (current-text text))
    (for-each (lambda (pair)
                (set! current-text (string-replace current-text (car pair) (cadr pair))))
              replacements)
    current-text))