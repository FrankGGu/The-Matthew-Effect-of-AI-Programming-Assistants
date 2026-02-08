#lang racket
(require racket/set)

(define (greatest-english-letter s)
  (define lower-chars (set))
  (define upper-chars (set))

  (for-each
   (lambda (c)
     (cond
       ((char-lower-case? c) (set! lower-chars (set-add lower-chars c)))
       ((char-upper-case? c) (set! upper-chars (set-add upper-chars c)))))
   (string->list s))

  (let loop ([char-code (char->integer #\Z)])
    (if (< char-code (char->integer #\A))
        ""
        (let* ([upper-char (integer->char char-code)]
               [lower-char (char-downcase upper-char)])
          (if (and (set-contains? lower-chars lower-char)
                   (set-contains? upper-chars upper-char))
              (string upper-char)
              (loop (- char-code 1)))))))