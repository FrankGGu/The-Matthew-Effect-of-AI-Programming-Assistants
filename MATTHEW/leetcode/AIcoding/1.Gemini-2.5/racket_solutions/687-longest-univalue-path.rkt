(struct TreeNode (val left right))

(define (longest-univalue-path root)
  (define max-univalue-path 0)

  (define (dfs node)
    (if (not node)
        0
        (let* ([left-len (dfs (TreeNode-left node))]
               [right-len (dfs (TreeNode-right node))]
               [left-arrow 0]
               [right-arrow 0])

          (when (and (TreeNode-left node)
                     (= (TreeNode-val (TreeNode-left node)) (TreeNode-val node)))
            (set! left-arrow (+ left-len 1)))

          (when (and (TreeNode-right node)
                     (= (TreeNode-val (TreeNode-right node)) (TreeNode-val node)))
            (set! right-arrow (+ right-len 1)))

          (set! max-univalue-path (max max-univalue-path (+ left-arrow right-arrow)))

          (max left-arrow right-arrow))))

  (dfs root)
  max-univalue-path)