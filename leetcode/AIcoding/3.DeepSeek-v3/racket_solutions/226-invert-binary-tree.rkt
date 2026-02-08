(define/contract (invert-tree root)
  (-> (or/c null? tree-node?) (or/c null? tree-node?))
  (if (null? root)
      null
      (let ([left (invert-tree (tree-node-left root))]
            [right (invert-tree (tree-node-right root))])
        (tree-node (tree-node-val root) right left))))