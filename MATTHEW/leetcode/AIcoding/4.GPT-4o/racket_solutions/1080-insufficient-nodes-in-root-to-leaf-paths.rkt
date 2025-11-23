#lang racket

(define (sufficientSubset root limit)
  (define (dfs node sum)
    (if (null? node)
        #f
        (define new-sum (+ sum (node-val node)))
        (if (and (null? (left node)) (null? (right node)))
            (if (>= new-sum limit) node #f)
            (define left-result (dfs (left node) new-sum))
            (define right-result (dfs (right node) new-sum))
            (if (and (null? left-result) (null? right-result))
                #f
                (make-node (node-val node) left-result right-result)))))
  (if (null? root)
      #f
      (dfs root 0)))

(define (make-node val left right)
  (list 'node val left right))

(define (node-val node)
  (second node))

(define (left node)
  (third node))

(define (right node)
  (fourth node))