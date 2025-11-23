#lang racket

(define (max-points-after-enemy-battles nums)
  (define (helper nums)
    (cond [(null? nums) 0]
          [(null? (cdr nums)) (car nums)]
          [else
           (let ([a (car nums)]
                 [b (cadr nums)])
             (if (>= b a)
                 (+ a (helper (cddr nums)))
                 (max (+ a (helper (cddr nums))) (helper (cdr nums)))))]))
  (helper nums))