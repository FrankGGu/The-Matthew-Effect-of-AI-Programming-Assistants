(define-struct TreeNode (val left right))

(define (increasing-bst root)
  (define new-root #f)
  (define current-tail #f)

  (define (inorder-traverse node)
    (when node
      (inorder-traverse (TreeNode-left node))

      (if (not new-root)
          (begin
            (set! new-root node)
            (set! current-tail node))
          (begin
            (set-TreeNode-right! current-tail node)
            (set! current-tail node)))

      (set-TreeNode-left! node #f)

      (inorder-traverse (TreeNode-right node))))

  (inorder-traverse root)
  new-root)