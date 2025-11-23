#lang racket

(define (isValidBST root)
  (define (helper node min-val max-val)
    (cond
      ;; An empty node is always a valid BST
      [(null? node) #t]
      ;; Check the current node's value against its bounds
      [else
       (let ([node-val (TreeNode-val node)])
         (and
          ;; If a minimum bound exists, the node's value must be strictly greater
          (if (not (null? min-val))
              (> node-val min-val)
              #t)
          ;; If a maximum bound exists, the node's value must be strictly less
          (if (not (null? max-val))
              (< node-val max-val)
              #t)
          ;; Recursively check the left subtree, updating the maximum bound to the current node's value
          (helper (TreeNode-left node) min-val node-val)
          ;; Recursively check the right subtree, updating the minimum bound to the current node's value
          (helper (TreeNode-right node) node-val max-val))))]))

  ;; Start the validation from the root with no initial minimum or maximum bounds
  (helper root null null))