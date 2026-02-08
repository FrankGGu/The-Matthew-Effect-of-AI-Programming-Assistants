#lang racket

(define (decode-message key message)
  (define mapping (make-hash))
  (define current-alphabet-code (char->integer #\a))

  (for-each
   (lambda (k-char)
     (unless (char-whitespace? k-char)
       (when (not (hash-has-key? mapping k-char))
         (hash-set! mapping k-char (integer->char current-alphabet-code))
         (set! current-alphabet-code (+ current-alphabet-code 1)))))
   (string->list key))

  (list->string
   (for/list ([m-char (string->list message)])
     (if (char-whitespace? m-char)
         m-char
         (hash-ref mapping m-char)))))