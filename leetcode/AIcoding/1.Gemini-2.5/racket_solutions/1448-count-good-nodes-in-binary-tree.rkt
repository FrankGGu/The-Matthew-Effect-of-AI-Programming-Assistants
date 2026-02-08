(define (goodNodes root)
  (define (dfs node current-max-val)
    (if (not node)
        0
        (let* ([node-val (TreeNode-val node)]
               [is-good? (>= node-val current-max-val)]
               [new-max-for-children (max node-val current-max-val)]
               [left-count (dfs (TreeNode-left node) new-max-for-children)]
               [right-count (dfs (TreeNode-right node) new-max-for-children)])
          (+ (if is-good? 1 0) left-count right-count))))

  (if (not root)
      0
      (dfs root (TreeNode-val root))))