#lang racket

(struct TreeNode (val left right))

(define (trimBST root low high)
  (cond
    [(null? root) #f]
    [(< (TreeNode-val root) low) (trimBST (TreeNode-right root) low high)]
    [(> (TreeNode-val root) high) (trimBST (TreeNode-left root) low high)]
    [else (TreeNode (TreeNode-val root)
                    (trimBST (TreeNode-left root) low high)
                    (trimBST (TreeNode-right root) low high))]))