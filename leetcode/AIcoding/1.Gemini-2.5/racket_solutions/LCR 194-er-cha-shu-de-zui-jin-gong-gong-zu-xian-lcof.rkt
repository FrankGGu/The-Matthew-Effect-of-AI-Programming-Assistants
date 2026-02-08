(struct TreeNode (val left right))

(define (lowest-common-ancestor root p q)
  (cond
    [(not root) #f]
    [(or (eq? root p) (eq? root q)) root]
    [else
     (define left-lca (lowest-common-ancestor (TreeNode-left root) p q))
     (define right-lca (lowest-common-ancestor (TreeNode-right root) p q))
     (cond
       [(and left-lca right-lca) root]
       [left-lca left-lca]
       [right-lca right-lca]
       [else #f])]))