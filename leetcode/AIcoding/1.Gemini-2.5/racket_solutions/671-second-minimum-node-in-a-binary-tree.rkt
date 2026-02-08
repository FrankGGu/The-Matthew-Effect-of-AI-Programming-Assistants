(define (find-second-minimum-value root)
  (let ([min-val (TreeNode-val root)]
        [second-min-val +inf.0])

    (define (dfs node)
      (when node
        (let ([current-val (TreeNode-val node)])
          (cond
            [(= current-val min-val)
             (dfs (TreeNode-left node))
             (dfs (TreeNode-right node))]

            [(< current-val second-min-val)
             (set! second-min-val current-val)]))))

    (dfs root)

    (if (= second-min-val +inf.0)
        -1
        second-min-val)))