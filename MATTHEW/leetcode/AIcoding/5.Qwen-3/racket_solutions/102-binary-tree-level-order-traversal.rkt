#lang racket

(define (level-order root)
  (define (traverse nodes result)
    (if (null? nodes)
        result
        (let* ([current-values (map (lambda (node) (if node (node-val node) #f)) nodes)]
               [next-nodes (apply append (map (lambda (node) (filter identity (list (if node (node-left node) #f) (if node (node-right node) #f)))) nodes))])
          (traverse next-nodes (append result (list current-values))))))
  (traverse (list root) '()))