#lang racket
(define/contract (min-bitwise-array nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define n (length nums))
  (define res (make-vector n 0))
  (vector-set! res 0 (car nums))
  (for ([i (in-range 1 n)])
    (vector-set! res i (bitwise-and (vector-ref res (- i 1)) (list-ref nums i))))
  (vector->list res))