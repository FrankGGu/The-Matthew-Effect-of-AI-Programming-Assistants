(struct TreeNode (val left right))

(define (max-depth root)
  (if (not root)
      0
      (+ 1 (max (max-depth (TreeNode-left root))
                (max-depth (TreeNode-right root))))))