#lang racket

(define (bit-change a b)
  (define (count-set-bits n)
    (if (= n 0)
        0
        (+ (modulo n 2) (count-set-bits (quotient n 2)))))
  (count-set-bits (bitwise-xor a b)))