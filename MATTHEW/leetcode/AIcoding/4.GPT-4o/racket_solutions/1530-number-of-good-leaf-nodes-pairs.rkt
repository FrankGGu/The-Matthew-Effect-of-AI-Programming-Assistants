#lang racket

(define (countPairs root distance)
  (define (dfs node)
    (if (null? node)
        '()
        (let* ((left (dfs (tree-left node)))
               (right (dfs (tree-right node)))
               (count (for/sum ((l left) (r right) #:when (<= (+ l r 2) distance))
                               1)))
          (cons count (map (lambda (x) (+ x 1)) (append left right))))))
  (apply + (dfs root)))