#lang racket

(define (count-non-decreasing-subarrays nums k)
  (define n (length nums))
  (define dp (make-vector n 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 n)])
    (when (<= (- (list-ref nums i) (list-ref nums (- i 1))) k)
      (vector-set! dp i (+ (vector-ref dp (- i 1)) 1))))
  (apply + (vector->list dp)))