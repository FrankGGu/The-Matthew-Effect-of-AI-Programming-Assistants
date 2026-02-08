#lang racket

(define (count-orders n)
  (define mod 1000000007)
  (let loop ([i 1] [res 1])
    (if (> i n)
        res
        (loop (add1 i) (modulo (* res (* i (- (* 2 i) 1))) mod)))))