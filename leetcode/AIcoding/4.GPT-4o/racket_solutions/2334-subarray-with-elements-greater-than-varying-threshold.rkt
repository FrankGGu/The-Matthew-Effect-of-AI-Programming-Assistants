#lang racket

(define (numSubarrayBoundedMax A L U)
  (define (count-bound max)
    (define count 0)
    (define result 0)
    (for ([x A])
      (if (<= x max)
          (begin
            (set! count (+ count 1))
            (set! result (+ result count)))
          (set! count 0)))
    result)
  (- (count-bound U) (count-bound (sub1 L)))
)

(define (numSubarrayBoundedMax A L U)
  (count-subarrays A L U))