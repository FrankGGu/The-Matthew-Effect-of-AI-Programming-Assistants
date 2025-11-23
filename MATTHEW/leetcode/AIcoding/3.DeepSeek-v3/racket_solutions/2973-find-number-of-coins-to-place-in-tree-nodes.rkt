#lang racket

(define (number-of-coins tree)
  (define (sum-tree t)
    (if (null? t)
        0
        (+ (car t) (sum-tree (cadr t)) (sum-tree (caddr t)))))
  (define (dfs t)
    (if (null? t)
        (list 0 0)
        (let* ([left (dfs (cadr t))]
               [right (dfs (caddr t))]
               [sum (+ (car t) (car left) (car right))]
          (list sum (max (abs (- (car left) (car right))) (max (cdr left) (cdr right))))))
  (let ([res (dfs tree)])
    (cdr res)))