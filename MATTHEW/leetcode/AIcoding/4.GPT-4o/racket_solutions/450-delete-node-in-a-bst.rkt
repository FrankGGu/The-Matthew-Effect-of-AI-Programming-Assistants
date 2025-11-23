#lang racket

(struct TreeNode (val left right) #:transparent)

(define (deleteNode root key)
  (cond
    [(null? root) #f]
    [(< key (TreeNode-val root)) (TreeNode (TreeNode-val root) (deleteNode (TreeNode-left root) key) (TreeNode-right root))]
    [(> key (TreeNode-val root)) (TreeNode (TreeNode-val root) (TreeNode-left root) (deleteNode (TreeNode-right root) key))]
    [else
     (cond
       [(null? (TreeNode-left root)) (TreeNode-right root)]
       [(null? (TreeNode-right root)) (TreeNode-left root)]
       [else
        (let ([minNode (findMin (TreeNode-right root))])
          (TreeNode (TreeNode-val minNode) (TreeNode-left root) (deleteNode (TreeNode-right root) (TreeNode-val minNode))))])])]))

(define (findMin node)
  (if (null? (TreeNode-left node))
      node
      (findMin (TreeNode-left node))))