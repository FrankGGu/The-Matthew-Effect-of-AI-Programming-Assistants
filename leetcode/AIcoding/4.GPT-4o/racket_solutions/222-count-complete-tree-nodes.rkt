#lang racket

(struct TreeNode (val left right))

(define (countNodes root)
  (if (null? root)
      0
      (+ 1 (countNodes (TreeNode-left root)) (countNodes (TreeNode-right root)))))