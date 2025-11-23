#lang racket

(define (is-sub-path head root)
  (define (dfs node path)
    (cond [(not node) #f]
          [(equal? path (list)) #t]
          [else
           (or (dfs (node-left node) (if (equal? (node-val node) (car path)) (cdr path) (if (equal? (node-val node) (car path)) (cdr path) head)))
               (dfs (node-right node) (if (equal? (node-val node) (car path)) (cdr path) head)))]))
  (dfs root head))