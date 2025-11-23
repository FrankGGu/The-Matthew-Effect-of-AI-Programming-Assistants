(struct TreeNode (val left right))

(define (find-bottom-left-value root)
  (let ([max-depth 0]
        [result (TreeNode-val root)])
    (define (dfs node current-depth)
      (when node
        (when (> current-depth max-depth)
          (set! max-depth current-depth)
          (set! result (TreeNode-val node)))
        (dfs (TreeNode-left node) (+ current-depth 1))
        (dfs (TreeNode-right node) (+ current-depth 1))))
    (dfs root 0)
    result))