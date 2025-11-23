#lang racket

(define (can-construct ransomNote magazine)
  (define char-counts (make-hash))

  (for ([char (string->list magazine)])
    (hash-set! char-counts char (+ (hash-ref char-counts char 0) 1)))

  (for/andmap ([char (string->list ransomNote)])
    (define count (hash-ref char-counts char 0))
    (if (> count 0)
        (begin
          (hash-set! char-counts char (- count 1))
          #t)
        #f)))