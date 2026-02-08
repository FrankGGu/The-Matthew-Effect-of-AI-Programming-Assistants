#lang racket

(struct TreeNode (val left right) #:transparent)

(define (checkTree root)
  (= (TreeNode-val root)
     (+ (TreeNode-val (TreeNode-left root))
        (TreeNode-val (TreeNode-right root)))))