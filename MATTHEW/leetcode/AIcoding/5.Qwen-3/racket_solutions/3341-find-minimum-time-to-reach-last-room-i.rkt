#lang racket

(define (min-time rooms)
  (define n (length rooms))
  (define dp (make-vector n 0))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 n)])
    (vector-set! dp i (+ (vector-ref dp (sub1 i)) 1)))
  (for ([i (in-range (sub1 n) -1 -1)])
    (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (add1 i)) 1))))
  (vector-ref dp (sub1 n)))