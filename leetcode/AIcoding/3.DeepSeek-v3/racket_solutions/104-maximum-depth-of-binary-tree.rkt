(define/contract (max-depth root)
  (-> (or/c null? tree-node?) exact-integer?)
  (if (null? root)
      0
      (+ 1 (max (max-depth (tree-node-left root))
                (max-depth (tree-node-right root))))))