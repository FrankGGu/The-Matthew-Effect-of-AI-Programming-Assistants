#lang racket

(struct node (val left right))

(define (max-points root)
  (define (dfs n)
    (if (null? n)
        (values 0 0)
        (let-values ([(left-max left-coin) (dfs (node-left n))]
                     [(right-max right-coin) (dfs (node-right n))])
          (define total-coin (+ (node-val n) left-coin right-coin))
          (values (max left-max right-max total-coin) total-coin))))
  (car (dfs root)))

(define (maxPoints root)
  (max-points root))