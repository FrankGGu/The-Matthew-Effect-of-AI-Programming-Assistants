(define-struct TreeNode (val left right))

(define (sum-root-to-leaf root)
  (define (dfs node current-sum)
    (cond
      [(eq? node #f) 0]
      [else
       (define new-sum (+ (* current-sum 2) (TreeNode-val node)))
       (if (and (eq? (TreeNode-left node) #f) (eq? (TreeNode-right node) #f))
           new-sum
           (+ (dfs (TreeNode-left node) new-sum)
              (dfs (TreeNode-right node) new-sum)))]))
  (dfs root 0))