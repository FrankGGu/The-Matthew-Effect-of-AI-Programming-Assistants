(struct TreeNode (val left right) #:mutable)

(define/contract (sufficient-subset root limit)
  (-> (or/c TreeNode null?) integer? (or/c TreeNode null?))
  (define (dfs-prune node current-path-sum limit)
    (if (null? node)
        null
        (let* ((new-sum (+ current-path-sum (TreeNode-val node)))
               (is-leaf? (and (null? (TreeNode-left node)) (null? (TreeNode-right node)))))
          (if is-leaf?
              (if (>= new-sum limit)
                  node
                  null)
              (let* ((left-child (dfs-prune (TreeNode-left node) new-sum limit))
                     (right-child (dfs-prune (TreeNode-right node) new-sum limit)))
                (set-TreeNode-left! node left-child)
                (set-TreeNode-right! node right-child)
                (if (and (null? left-child) (null? right-child))
                    null
                    node))))))
  (dfs-prune root 0 limit))