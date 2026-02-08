(define/contract (insert-into-bst root val)
  (-> (or/c null? tree-node?) exact-integer? (or/c null? tree-node?))
  (if (null? root)
      (make-tree-node val null null)
      (let ([node-val (tree-node-val root)])
        (cond
          [(< val node-val) (make-tree-node node-val
                                           (insert-into-bst (tree-node-left root) val)
                                           (tree-node-right root))]
          [else (make-tree-node node-val
                                (tree-node-left root)
                                (insert-into-bst (tree-node-right root) val))]))))