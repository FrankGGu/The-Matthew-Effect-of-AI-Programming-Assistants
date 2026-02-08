(struct TreeNode (val left right))

(define (increasing-bst root)
  (define (helper node current-tail)
    (if (not node)
        current-tail
        (let* ((right-tree (helper (TreeNode-right node) current-tail))
               (new-node (TreeNode (TreeNode-val node) #f right-tree)))
          (helper (TreeNode-left node) new-node))))

  (helper root #f))