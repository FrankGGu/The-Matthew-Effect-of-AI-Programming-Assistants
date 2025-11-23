(define-struct TreeNode (val left right))

(define (postorderTraversal root)
  (if (null? root)
      '()
      (append (postorderTraversal (TreeNode-left root))
              (postorderTraversal (TreeNode-right root))
              (list (TreeNode-val root)))))