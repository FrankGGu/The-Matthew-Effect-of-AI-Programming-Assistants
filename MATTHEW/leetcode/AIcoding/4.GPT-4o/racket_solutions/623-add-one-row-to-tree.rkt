#lang racket

(struct TreeNode (val left right) #:transparent)

(define (addOneRow root v d)
  (if (zero? d)
      (TreeNode. v root '())
      (define (helper node depth)
        (if (null? node)
            '()
            (if (= depth d)
                (TreeNode. v (TreeNode. (TreeNode-val node) (TreeNode-left node) '())
                               (TreeNode. (TreeNode-val node) '() (TreeNode-right node)))
                (TreeNode. (TreeNode-val node) (helper (TreeNode-left node) (add1 depth))
                           (helper (TreeNode-right node) (add1 depth))))))
      (helper root 1)))

(define (addOneRow-to-tree root v d)
  (addOneRow root v d))