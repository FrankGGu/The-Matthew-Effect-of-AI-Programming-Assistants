#lang racket

(define (count-good-numbers n)
  (define MOD 1000000007)
  (define (pow x n)
    (cond
      [(zero? n) 1]
      [(even? n) (modulo (sqr (pow x (quotient n 2))) MOD)]
      [else (modulo (* x (pow x (sub1 n))) MOD]))
  (let* ([even (pow 5 (quotient (add1 n) 2))]
         [odd (pow 4 (quotient n 2))])
    (modulo (* even odd) MOD)))