#lang racket

(define (smallest-divisible-digit-product n)
  (define (product-of-digits x)
    (if (= x 0)
        1
        (* (modulo x 10) (product-of-digits (quotient x 10)))))
  (define (helper x)
    (if (= (modulo x (product-of-digits x)) 0)
        x
        (helper (+ x 1))))
  (helper n))