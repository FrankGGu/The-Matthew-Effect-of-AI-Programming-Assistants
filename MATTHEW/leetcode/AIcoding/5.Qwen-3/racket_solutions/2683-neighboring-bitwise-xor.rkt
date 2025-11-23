#lang racket

(define/contract (xor-beautiful-array n)
  (-> exact-integer? (listof exact-integer?))
  (if (= n 1)
      '(1)
      (let ([prev (xor-beautiful-array (quotient n 2))])
        (append (map (lambda (x) (* x 2)) prev)
                (map (lambda (x) (+ (* x 2) 1)) prev)))))