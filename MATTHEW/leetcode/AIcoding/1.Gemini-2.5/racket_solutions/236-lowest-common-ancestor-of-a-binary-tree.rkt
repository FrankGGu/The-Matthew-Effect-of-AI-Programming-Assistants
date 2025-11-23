(struct TreeNode (val left right) #:transparent)

(define (lowest-common-ancestor root p q)
  (cond
    [(or (null? root) (eq? root p) (eq? root q))
     root]
    [else
     (let ([left-lca (lowest-common-ancestor (TreeNode-left root) p q)]
           [right-lca (lowest-common-ancestor (TreeNode-right root) p q)])
       (cond
         [(and (not (null? left-lca)) (not (null? right-lca)))
          root]
         [(not (null? left-lca))
          left-lca]
         [(not (null? right-lca))
          right-lca]
         [else
          null]))]))