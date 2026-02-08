#lang racket

(define (numberOfSequence n m k)
  (define mod 1000000007)
  (define (pow x n)
    (cond [(= n 0) 1]
          [(even? n) (modulo (sqr (pow x (quotient n 2))) mod)]
          [else (modulo (* x (pow x (sub1 n))) mod]))
  (if (or (< m k) (< (+ k 1) m))
      0
      (modulo (* (pow m (sub1 k)) (pow (sub1 m) (- n k 1))) mod)))