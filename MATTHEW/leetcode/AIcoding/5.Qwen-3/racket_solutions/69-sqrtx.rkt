#lang racket

(define (my-sqrt x)
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.000001))
  (sqrt-iter 1.0))