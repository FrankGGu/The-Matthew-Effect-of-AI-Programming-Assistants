(define (convert-bst root)
  (define current-sum 0)

  (define (traverse node)
    (when node
      (traverse (TreeNode-right node))
      (set! current-sum (+ current-sum (TreeNode-val node)))
      (set-TreeNode-val! node current-sum)
      (traverse (TreeNode-left node))))

  (traverse root)
  root)