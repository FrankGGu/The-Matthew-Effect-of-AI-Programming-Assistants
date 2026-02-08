(define/contract (delete-node root key)
  (-> (or/c #f tree-node?) exact-integer? (or/c #f tree-node?))
  (cond
    [(not root) #f]
    [(< key (tree-node-val root))
     (set-tree-node-left! root (delete-node (tree-node-left root) key))
     root]
    [(> key (tree-node-val root))
     (set-tree-node-right! root (delete-node (tree-node-right root) key))
     root]
    [else
     (cond
       [(not (tree-node-left root)) (tree-node-right root)]
       [(not (tree-node-right root)) (tree-node-left root)]
       [else
        (let ([min-node (find-min (tree-node-right root))])
          (set-tree-node-val! root (tree-node-val min-node))
          (set-tree-node-right! root (delete-node (tree-node-right root) (tree-node-val min-node)))
          root)])]))

(define (find-min node)
  (if (not (tree-node-left node))
      node
      (find-min (tree-node-left node))))