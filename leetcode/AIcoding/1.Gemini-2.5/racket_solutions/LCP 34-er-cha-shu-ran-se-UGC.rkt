(struct TreeNode (val left right))

(define (get-target-copy original cloned target)
  (cond
    [(null? original) null]
    [(eq? original target) cloned]
    [else
     (let ([left-result (get-target-copy (TreeNode-left original) (TreeNode-left cloned) target)])
       (if (not (null? left-result))
           left-result
           (get-target-copy (TreeNode-right original) (TreeNode-right cloned) target)))]))