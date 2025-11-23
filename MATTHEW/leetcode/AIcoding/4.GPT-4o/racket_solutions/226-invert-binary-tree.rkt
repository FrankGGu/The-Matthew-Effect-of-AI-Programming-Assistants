#lang racket

(struct TreeNode (val left right))

(define (invertTree root)
  (if (null? root)
      null
      (let* ([left (invertTree (TreeNode-left root))]
             [right (invertTree (TreeNode-right root))])
        (TreeNode (TreeNode-val root) right left))))