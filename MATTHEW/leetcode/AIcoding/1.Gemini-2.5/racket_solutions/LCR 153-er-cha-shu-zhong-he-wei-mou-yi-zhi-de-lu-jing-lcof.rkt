(struct TreeNode (val left right))

(define (hasPathSum root targetSum)
  (cond
    [(null? root) #f]
    [(and (null? (TreeNode-left root)) (null? (TreeNode-right root)))
     (= (TreeNode-val root) targetSum)]
    [else
     (or (hasPathSum (TreeNode-left root) (- targetSum (TreeNode-val root)))
         (hasPathSum (TreeNode-right root) (- targetSum (TreeNode-val root))))]))