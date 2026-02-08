(struct TreeNode (val left right) #:transparent)

(define (inorder-traversal root)
  (if (null? root)
      '()
      (append (inorder-traversal (TreeNode-left root))
              (list (TreeNode-val root))
              (inorder-traversal (TreeNode-right root)))))