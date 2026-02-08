(struct TreeNode (val left right))

(define (has-path-sum root targetSum)
  (cond
    [(not root) #f]
    [(and (not (TreeNode-left root)) (not (TreeNode-right root)))
     (= (TreeNode-val root) targetSum)]
    [else
     (define remainingSum (- targetSum (TreeNode-val root)))
     (or (has-path-sum (TreeNode-left root) remainingSum)
         (has-path-sum (TreeNode-right root) remainingSum))]))