(define-struct TreeNode (val left right) #:mutable)

(define (flatten root)
  (define prev #f)

  (define (dfs node)
    (when node
      (dfs (TreeNode-right node))
      (dfs (TreeNode-left node))

      (set-TreeNode-right! node prev)
      (set-TreeNode-left! node #f)
      (set! prev node)))

  (dfs root))