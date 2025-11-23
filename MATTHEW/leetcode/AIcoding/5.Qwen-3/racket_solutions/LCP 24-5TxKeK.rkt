#lang racket

(define (number-game nums)
  (let loop ([nums nums])
    (if (null? nums)
        '()
        (let* ([sorted (sort nums <)]
               [a (car sorted)]
               [b (cadr sorted)]
               [rest (cddr sorted)])
          (cons (+ a b) (loop rest))))))