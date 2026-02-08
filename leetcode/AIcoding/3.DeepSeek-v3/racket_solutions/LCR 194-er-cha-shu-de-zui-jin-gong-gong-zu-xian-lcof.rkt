(define/contract (lowest-common-ancestor root p q)
  (-> (or/c #f tree-node?) tree-node? tree-node? (or/c #f tree-node?))
  (cond
    [(not root) #f]
    [(or (eq? root p) (eq? root q)) root]
    [else
     (let ([left (lowest-common-ancestor (tree-node-left root) p q)]
           [right (lowest-common-ancestor (tree-node-right root) p q)])
       (cond
         [(and left right) root]
         [left left]
         [right right]
         [else #f]))]))