#lang racket

(define (is-reachable targetX targetY)
  (define (gcd a b)
    (if (= b 0) a (gcd b (modulo a b))))
  (let loop ((x targetX) (y targetY))
    (cond
      [(= x 1) (= (gcd x y) 1)]
      [(= y 1) (= (gcd x y) 1)]
      [(= x y) (= x 1)]
      [(> x y) (loop (quotient x (gcd x y)) y)]
      [else (loop x (quotient y (gcd x y)))])))