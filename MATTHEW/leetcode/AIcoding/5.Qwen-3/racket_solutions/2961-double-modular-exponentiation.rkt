#lang racket

(define (mod-exp a b mod)
  (cond ((= b 0) 1)
        ((even? b) (let ((temp (mod-exp a (/ b 2) mod)))
                     (modulo (* temp temp) mod)))
        (else (modulo (* a (mod-exp a (- b 1) mod)) mod))))

(define (double-modular-exponentiation x y m)
  (mod-exp x y m))