#lang racket

(define (sum-digits n)
  (if (zero? n)
      0
      (+ (remainder n 10) (sum-digits (quotient n 10)))))

(define (solve nums)
  (apply + (map sum-digits nums)))