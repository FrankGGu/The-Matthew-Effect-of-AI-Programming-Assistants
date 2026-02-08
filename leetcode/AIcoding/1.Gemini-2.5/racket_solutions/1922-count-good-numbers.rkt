#lang racket

(define (count-good-numbers n)
  (define MOD 1000000007)

  (define (mod-expt base exp modulus)
    (define (loop b e acc)
      (cond
        [(= e 0) acc]
        [(odd? e) (loop (modulo (* b b) modulus) (quotient e 2) (modulo (* acc b) modulus))]
        [else (loop (modulo (* b b) modulus) (quotient e 2) acc)]))
    (loop (modulo base modulus) exp 1))

  (mod-expt 5 n MOD))