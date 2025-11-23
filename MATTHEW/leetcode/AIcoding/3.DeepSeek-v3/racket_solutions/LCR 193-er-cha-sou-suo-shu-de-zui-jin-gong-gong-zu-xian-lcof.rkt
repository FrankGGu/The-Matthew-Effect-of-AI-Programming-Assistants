(define/contract (lowest-common-ancestor root p q)
  (-> (or/c #f tree-node?) tree-node? tree-node? tree-node?)
  (cond
    [(or (not root) (eq? root p) (eq? root q)) root]
    [(and (< (tree-node-val p) (tree-node-val root))
          (< (tree-node-val q) (tree-node-val root)))
     (lowest-common-ancestor (tree-node-left root) p q)]
    [(and (> (tree-node-val p) (tree-node-val root))
          (> (tree-node-val q) (tree-node-val root)))
     (lowest-common-ancestor (tree-node-right root) p q)]
    [else root]))