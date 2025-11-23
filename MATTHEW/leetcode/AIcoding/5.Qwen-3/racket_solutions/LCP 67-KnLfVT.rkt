#lang racket

(define (tree-matcher root target)
  (define (dfs node t-node)
    (cond [(not node) #f]
          [(not t-node) #t]
          [(not (= (node-val node) (node-val t-node))) #f]
          [else (and (dfs (node-left node) (node-left t-node))
                     (dfs (node-right node) (node-right t-node)))]))
  (define (check node)
    (or (dfs node target)
        (if (not node) #f (or (check (node-left node)) (check (node-right node))))))
  (check root))

(define (make-node val left right)
  (list val left right))

(define (node-val node) (car node))
(define (node-left node) (cadr node))
(define (node-right node) (caddr node))