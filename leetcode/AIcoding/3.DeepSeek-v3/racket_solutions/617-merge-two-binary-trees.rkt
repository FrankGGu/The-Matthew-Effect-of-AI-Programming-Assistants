(define/contract (merge-trees t1 t2)
  (-> (or/c null? tree-node?) (or/c null? tree-node?) (or/c null? tree-node?))
  (cond
    [(null? t1) t2]
    [(null? t2) t1]
    [else
     (define merged (tree-node (+ (tree-node-val t1) (tree-node-val t2)) null null))
     (set-tree-node-left! merged (merge-trees (tree-node-left t1) (tree-node-left t2)))
     (set-tree-node-right! merged (merge-trees (tree-node-right t1) (tree-node-right t2)))
     merged]))