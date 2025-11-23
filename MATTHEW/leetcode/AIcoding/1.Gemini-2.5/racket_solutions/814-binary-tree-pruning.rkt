(struct TreeNode (val left right))

(define/public (prune-tree root)
  (if (not root)
      #f
      (let* ([left-pruned (prune-tree (TreeNode-left root))]
             [right-pruned (prune-tree (TreeNode-right root))])
        (if (and (= (TreeNode-val root) 0)
                 (not left-pruned)
                 (not right-pruned))
            #f
            (TreeNode (TreeNode-val root) left-pruned right-pruned)))))