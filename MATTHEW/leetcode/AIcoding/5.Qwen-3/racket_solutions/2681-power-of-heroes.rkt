#lang racket

(define (power-of-heroes nums k)
  (define (helper lst)
    (cond [(null? lst) '()]
          [(>= (length lst) k) (append (list (apply + (take lst k))) (helper (drop lst 1)))]
          [else '()]))
  (apply + (helper nums)))