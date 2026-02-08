(define-struct TreeNode (val left right))

(define (preorderTraversal root)
  (if (null? root)
      '()
      (append (list (TreeNode-val root))
              (preorderTraversal (TreeNode-left root))
              (preorderTraversal (TreeNode-right root)))))