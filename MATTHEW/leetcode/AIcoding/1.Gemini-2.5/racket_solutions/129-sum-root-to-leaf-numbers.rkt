(struct TreeNode (val left right))

(define (sum-numbers root)
  (define (dfs node current-sum)
    (cond
      [(null? node) 0]
      [else
       (define new-sum (+ (* current-sum 10) (TreeNode-val node)))
       (cond
         [(and (null? (TreeNode-left node)) (null? (TreeNode-right node)))
          new-sum]
         [else
          (+ (dfs (TreeNode-left node) new-sum)
             (dfs (TreeNode-right node) new-sum))])]))

  (dfs root 0))