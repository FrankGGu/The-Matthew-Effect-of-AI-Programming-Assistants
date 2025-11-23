(define/contract (remove-leaf-nodes root target)
  (-> (or/c null? tree-node?) exact-integer? (or/c null? tree-node?))
  (if (null? root)
      null
      (let* ([left (remove-leaf-nodes (tree-node-left root) target)]
             [right (remove-leaf-nodes (tree-node-right root) target)]
            (if (and (null? left) (null? right) (= (tree-node-val root) target))
                null
                (begin
                  (set-tree-node-left! root left)
                  (set-tree-node-right! root right)
                  root)))))