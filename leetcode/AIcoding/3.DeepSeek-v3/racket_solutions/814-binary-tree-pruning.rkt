(define/contract (prune-tree root)
  (-> (or/c null? tree-node?) (or/c null? tree-node?))
  (if (null? root)
      null
      (let* ([left (prune-tree (tree-node-left root))]
              [right (prune-tree (tree-node-right root))])
        (if (and (null? left) (null? right) (zero? (tree-node-val root)))
            null
            (begin
              (set-tree-node-left! root left)
              (set-tree-node-right! root right)
              root)))))