#lang racket

(define (num-of-ways n)
  (define MOD 1000000007)
  (if (= n 1)
      12
      (let loop ([i 2] [a 6] [b 6])
        (if (> i n)
            (modulo (+ a b) MOD)
            (loop (add1 i)
                  (modulo (+ (* 3 a) (* 2 b)) MOD)
                  (modulo (+ (* 2 a) (* 2 b)) MOD)))))))