(struct TreeNode (val left right) #:mutable)

(define (prune-tree root)
  (if (null? root)
      null
      (begin
        (set-TreeNode-left! root (prune-tree (TreeNode-left root)))
        (set-TreeNode-right! root (prune-tree (TreeNode-right root)))
        (if (and (= (TreeNode-val root) 0)
                 (null? (TreeNode-left root))
                 (null? (TreeNode-right root)))
            null
            root))))