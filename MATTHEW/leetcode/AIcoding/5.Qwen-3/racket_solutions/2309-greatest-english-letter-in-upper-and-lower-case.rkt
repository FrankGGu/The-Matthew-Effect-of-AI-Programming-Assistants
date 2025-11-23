#lang racket

(define (greatest-letter s)
  (define lower (make-hash))
  (define upper (make-hash))
  (for ([c s])
    (if (char-lower-case? c)
        (hash-set! lower c #t)
        (hash-set! upper c #t)))
  (let loop ([i 25])
    (if (<= i 0)
        #f
        (let ([c (integer->char (+ 64 i))])
          (if (and (hash-has-key? upper c) (hash-has-key? lower (char-downcase c)))
              c
              (loop (- i 1)))))))