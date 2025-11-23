(define (max-ancestor-diff root)
  (cond
    [(null? root) 0]
    [else
     (define (dfs node min-so-far max-so-far)
       (if (null? node)
           0
           (let* ([current-val (TreeNode-val node)]
                  [diff1 (abs (- current-val min-so-far))]
                  [diff2 (abs (- current-val max-so-far))]
                  [current-max-diff (max diff1 diff2)]
                  [new-min (min min-so-far current-val)]
                  [new-max (max max-so-far current-val)])
             (max current-max-diff
                  (dfs (TreeNode-left node) new-min new-max)
                  (dfs (TreeNode-right node) new-min new-max)))))
     (dfs root (TreeNode-val root) (TreeNode-val root))]))