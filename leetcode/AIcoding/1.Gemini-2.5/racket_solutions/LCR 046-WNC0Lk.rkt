(struct TreeNode (val left right))

(define (right-side-view root)
  (define (dfs node depth acc-rev)
    (if (not node)
        acc-rev
        (let* ((current-val (TreeNode-val node))
               (updated-acc-rev (if (= depth (length acc-rev))
                                    (cons current-val acc-rev)
                                    acc-rev)))
          (dfs (TreeNode-left node) (+ depth 1)
               (dfs (TreeNode-right node) (+ depth 1) updated-acc-rev)))))
  (reverse (dfs root 0 '())))