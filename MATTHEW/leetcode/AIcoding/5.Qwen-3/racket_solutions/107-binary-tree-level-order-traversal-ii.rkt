#lang racket

(define (level-order-bottom root)
  (define (traverse nodes result)
    (if (null? nodes)
        result
        (let* ([values (map (lambda (n) (if n (node-val n) #f)) nodes)]
               [next-nodes (apply append (map (lambda (n) (filter identity (list (node-left n) (node-right n)))) nodes))])
          (traverse next-nodes (cons values result)))))
  (if (null? root)
      '()
      (traverse (list root) '())))

(define-struct node (val left right) #:mutable)