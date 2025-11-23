#lang racket

(define (num-of-copy-arrays nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ 1 (hash-ref freq n 0)))) nums)
  (define total 0)
  (for ([k (in-hash-keys freq)])
    (define cnt (hash-ref freq k))
    (set! total (+ total (* cnt (- cnt 1)))))
  total)