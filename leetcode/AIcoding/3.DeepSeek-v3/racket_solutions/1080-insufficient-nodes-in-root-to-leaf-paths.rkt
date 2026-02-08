#lang racket

(define (sufficient-subset root limit)
  (define (helper node sum)
    (if (not node)
        #f
        (let* ([current-sum (+ sum (node-val node))]
               [left (helper (node-left node) current-sum)]
               [right (helper (node-right node) current-sum)])
          (cond
            [(and (not left) (not right))
             (if (< current-sum limit) #f node)]
            [else
             (begin
               (set-node-left! node left)
               (set-node-right! node right)
               (if (or left right) node #f))]))))
  (helper root 0))

(define-struct node (val left right) #:mutable #:transparent)