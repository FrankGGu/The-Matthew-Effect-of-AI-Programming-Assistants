(struct TreeNode (val left right) #:transparent)

(define (invert-tree root)
  (if (null? root)
      null
      (TreeNode (TreeNode-val root)
                (invert-tree (TreeNode-right root))
                (invert-tree (TreeNode-left root)))))