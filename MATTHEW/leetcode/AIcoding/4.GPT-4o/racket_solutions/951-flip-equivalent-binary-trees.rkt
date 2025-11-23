#lang racket

(struct TreeNode ([val : Integer] [left : (or/c TreeNode #f)] [right : (or/c TreeNode #f)]))

(define (flipEquiv root1 root2)
  (cond
    [(and (not root1) (not root2)) #t]
    [(or (not root1) (not root2)) #f]
    [(not (= (TreeNode-val root1) (TreeNode-val root2))) #f]
    [else (or (and (flipEquiv (TreeNode-left root1) (TreeNode-left root2))
                   (flipEquiv (TreeNode-right root1) (TreeNode-right root2)))
              (and (flipEquiv (TreeNode-left root1) (TreeNode-right root2))
                   (flipEquiv (TreeNode-right root1) (TreeNode-left root2))))]))