(struct TreeNode (val left right))

(define (lowest-common-ancestor root p q)
  (cond
    [(and (> (TreeNode-val root) (TreeNode-val p))
          (> (TreeNode-val root) (TreeNode-val q)))
     (lowest-common-ancestor (TreeNode-left root) p q)]
    [(and (< (TreeNode-val root) (TreeNode-val p))
          (< (TreeNode-val root) (TreeNode-val q)))
     (lowest-common-ancestor (TreeNode-right root) p q)]
    [else
     root]))