(struct TreeNode (val left right))

(define/contract (sum-numbers root)
  (-> (or/c TreeNode #f) exact-integer?)
  (cond
    [(null? root) 0]
    [else
     (define (dfs node current-val)
       (if (null? node)
           0
           (let* ([new-val (+ (* current-val 10) (TreeNode-val node))]
                  [left (TreeNode-left node)]
                  [right (TreeNode-right node)])
             (if (and (null? left) (null? right))
                 new-val
                 (+ (dfs left new-val)
                    (dfs right new-val))))))
     (dfs root 0)]))