#lang racket

(struct TreeNode (val left right))

(define (checkTree root)
  (= (TreeNode-val root) 
     (+ (TreeNode-val (TreeNode-left root)) 
        (TreeNode-val (TreeNode-right root)))))