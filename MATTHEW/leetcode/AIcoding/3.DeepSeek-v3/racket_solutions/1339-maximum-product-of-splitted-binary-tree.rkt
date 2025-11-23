#lang racket

(define (max-product root)
  (define total 0)
  (define max-prod 0)

  (define (sum-tree node)
    (if (null? node)
        0
        (let ([left (sum-tree (vector-ref node 1))]
              [right (sum-tree (vector-ref node 2))])
          (+ (vector-ref node 0) left right))))

  (set! total (sum-tree root))

  (define (dfs node)
    (if (null? node)
        0
        (let* ([left (dfs (vector-ref node 1))]
               [right (dfs (vector-ref node 2))]
               [subtree-sum (+ (vector-ref node 0) left right)]
               [product (modulo (* subtree-sum (- total subtree-sum)) (expt 10 9 7))])
          (set! max-prod (max max-prod product))
          subtree-sum))

  (dfs root)
  max-prod)