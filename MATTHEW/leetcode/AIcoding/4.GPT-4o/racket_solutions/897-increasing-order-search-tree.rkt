#lang racket

(struct TreeNode ([val : Integer] [left : (or/c TreeNode #f)] [right : (or/c TreeNode #f)]))

(define (increasingOrderSearchTree root)
  (define values '())
  (define (inorder node)
    (when node
      (inorder (TreeNode-left node))
      (set! values (cons (TreeNode-val node) values))
      (inorder (TreeNode-right node))))
  (inorder root)

  (define (build-tree vals)
    (if (null? vals)
        #f
        (let ((new-node (TreeNode (car vals) #f #f)))
          (set! (TreeNode-right new-node) (build-tree (cdr vals)))
          new-node)))

  (build-tree (reverse values)))