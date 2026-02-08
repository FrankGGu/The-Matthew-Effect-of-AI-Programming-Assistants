#lang racket/base

(provide (rename-out [get-minimum-difference solution]))

(define (get-minimum-difference root)
  (define min-diff +inf.0)
  (define prev-val #f) ; #f indicates no previous node has been visited yet

  (define (inorder-traverse node)
    (when node
      ;; Traverse left subtree
      (inorder-traverse (TreeNode-left node))

      ;; Process current node
      (when (not (eq? prev-val #f)) ; If prev-val has been set (i.e., not the first node)
        (set! min-diff (min min-diff (abs (- (TreeNode-val node) prev-val)))))
      (set! prev-val (TreeNode-val node)) ; Update prev-val to current node's value

      ;; Traverse right subtree
      (inorder-traverse (TreeNode-right node))))

  (inorder-traverse root)
  min-diff)