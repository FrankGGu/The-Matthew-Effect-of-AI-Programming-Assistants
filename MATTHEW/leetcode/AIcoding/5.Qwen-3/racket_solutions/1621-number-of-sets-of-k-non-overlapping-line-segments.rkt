#lang racket

(define (number-of-sets n k)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (add1 n))])
    (vector-set! dp i (vector-ref dp (sub1 i)))
    (when (>= i k)
      (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i k))))))
  (vector-ref dp n))