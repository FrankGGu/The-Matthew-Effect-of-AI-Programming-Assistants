#lang racket

(define (make-tree-node val left right)
  (vector val left right))

(define (tree-node? x)
  (vector? x))

(define (tree-node-val node)
  (vector-ref node 0))

(define (tree-node-left node)
  (vector-ref node 1))

(define (tree-node-right node)
  (vector-ref node 2))

(define (subtree-with-all-deepest root)
  (define (dfs node)
    (if (not node)
        (cons 0 #f)
        (let* ([left (dfs (tree-node-left node))]
               [right (dfs (tree-node-right node))]
               [depth (add1 (max (car left) (car right)))]
               [child (if (= (car left) (car right))
                          (if (> (car left) 0)
                              (if (and (car left) (car right))
                                  (if (>= (car left) (car right))
                                      (tree-node-left node)
                                      (tree-node-right node))
                                  (if (car left)
                                      (tree-node-left node)
                                      (tree-node-right node)))
                              node)
                          (if (> (car left) (car right))
                              (tree-node-left node)
                              (tree-node-right node)))])
          (cons depth child))))
  (cdr (dfs root)))