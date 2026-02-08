(define (good-nodes root)
  (if (not root)
      0
      (let loop ((node root) (max-so-far (TreeNode-val root)))
        (if (not node)
            0
            (+ (if (>= (TreeNode-val node) max-so-far) 1 0)
               (loop (TreeNode-left node) (max max-so-far (TreeNode-val node)))
               (loop (TreeNode-right node) (max max-so-far (TreeNode-val node))))))))