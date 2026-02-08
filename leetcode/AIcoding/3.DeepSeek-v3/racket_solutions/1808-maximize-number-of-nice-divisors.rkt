#lang racket

(define (pow-mod x n mod)
  (cond
    [(= n 0) 1]
    [(even? n) (modulo (sqr (pow-mod x (/ n 2) mod)) mod)]
    [else (modulo (* x (pow-mod x (- n 1) mod)) mod)]))

(define (max-nice-divisors prime-factors)
  (if (= prime-factors 1)
      1
      (let* ([mod 1000000007]
             [q (quotient prime-factors 3)]
             [r (remainder prime-factors 3)]
             [result (cond
                       [(= r 0) (pow-mod 3 q mod)]
                       [(= r 1) (modulo (* (pow-mod 3 (- q 1) mod) 4) mod)]
                       [else (modulo (* (pow-mod 3 q mod) 2) mod])])
        result)))