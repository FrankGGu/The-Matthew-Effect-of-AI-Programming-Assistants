#lang racket

(struct TreeNode (val left right))

(define (sumEvenGrandparent root)
  (define (dfs node parent grandparent)
    (if (null? node)
        0
        (+ (if (even? grandparent) (TreeNode-val node) 0)
           (dfs (TreeNode-left node) (TreeNode-val node) parent)
           (dfs (TreeNode-right node) (TreeNode-val node) parent))))
  (dfs root 1 1))