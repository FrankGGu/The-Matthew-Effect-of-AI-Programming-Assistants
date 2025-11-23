#lang racket

(define (num-cuts n)
  (if (= n 1) 0 (- n (* 2 (quotient n 2)))))