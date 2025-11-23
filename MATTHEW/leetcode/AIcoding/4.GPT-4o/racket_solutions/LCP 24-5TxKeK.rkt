#lang racket

(define (digit-game n)
  (define (digit-sum x)
    (if (= x 0)
        0
        (+ (modulo x 10) (digit-sum (quotient x 10)))))
  (define (helper x)
    (if (< x 10)
        x
        (helper (digit-sum x))))
  (helper n))

(digit-game 38) ; Example usage