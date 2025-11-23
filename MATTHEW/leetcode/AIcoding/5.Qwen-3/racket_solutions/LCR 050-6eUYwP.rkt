#lang racket

(define (path-sum root target)
  (define (dfs node prefix-sum)
    (if (not node)
        0
        (+ (if (= (- prefix-sum target) 0) 1 0)
           (dfs (node-left node) (+ prefix-sum (node-val node)))
           (dfs (node-right node) (+ prefix-sum (node-val node))))))

  (define (helper node)
    (if (not node)
        0
        (+ (dfs node 0)
           (helper (node-left node))
           (helper (node-right node)))))

  (helper root))

(struct TreeNode (val left right) #:transparent)