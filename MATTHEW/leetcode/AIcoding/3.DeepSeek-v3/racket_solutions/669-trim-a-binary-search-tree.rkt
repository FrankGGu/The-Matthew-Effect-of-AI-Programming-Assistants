(define/contract (trim-bst root low high)
  (-> (or/c null? tree-node?) exact-integer? exact-integer? (or/c null? tree-node?))
  (cond
    [(null? root) null]
    [(< (tree-node-val root) low) (trim-bst (tree-node-right root) low high)]
    [(> (tree-node-val root) high) (trim-bst (tree-node-left root) low high)]
    [else
     (set-tree-node-left! root (trim-bst (tree-node-left root) low high))
     (set-tree-node-right! root (trim-bst (tree-node-right root) low high))
     root]))