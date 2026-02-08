(define/contract (invert-tree root)
  (-> (or/c #f tree-node?) (or/c #f tree-node?))
  (if (not root)
      #f
      (let ([left (invert-tree (tree-node-left root))]
            [right (invert-tree (tree-node-right root))])
        (tree-node (tree-node-val root) right left))))