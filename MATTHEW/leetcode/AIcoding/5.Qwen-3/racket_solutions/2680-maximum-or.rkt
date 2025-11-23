#lang racket

(define (max-or nums)
  (define n (length nums))
  (define result (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! result i (bitwise-ior (vector-ref nums i) (if (< i (sub1 n)) (vector-ref nums (add1 i)) 0))))
  (apply bitwise-ior (vector->list result)))