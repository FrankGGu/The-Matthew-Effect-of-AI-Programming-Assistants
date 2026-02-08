#lang racket

(define (inorder-successor root p)
  (let loop ([node root] [succ #f])
    (cond
      [(not node) succ]
      [(> (node-val p) (node-val node)) (loop (node-right node) succ)]
      [else (loop (node-left node) node)])))

(define (node-val node)
  (if node (vector-ref node 0) 0))

(define (node-left node)
  (if node (vector-ref node 1) #f))

(define (node-right node)
  (if node (vector-ref node 2) #f))