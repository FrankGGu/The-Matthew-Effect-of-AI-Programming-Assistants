#lang racket

(define/contract (apply-operations nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define (helper nums res)
    (cond [(null? nums) res]
          [(and (not (null? (cdr nums))) (= (car nums) (cadr nums))) 
           (helper (cddr nums) (cons (* (car nums) 2) res))]
          [else (helper (cdr nums) (cons (car nums) res))]))
  (reverse (helper nums '())))