#lang racket

(define (digit-sum n)
  (if (= n 0)
      0
      (+ (modulo n 10) (digit-sum (quotient n 10)))))

(define (smallest-index-with-digit-sum-equal-to-index nums)
  (for/first ([i (in-range (length nums))] #:when (= (digit-sum i) (list-ref nums i))) i))