#lang racket

(define (minimum-damage power)
  (define (helper damage power)
    (if (zero? power)
        damage
        (helper (+ damage (modulo power 10)) (quotient power 10))))
  (helper 0 power))