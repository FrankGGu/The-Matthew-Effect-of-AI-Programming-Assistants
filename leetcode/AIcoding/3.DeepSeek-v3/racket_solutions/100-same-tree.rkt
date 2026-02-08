(define/contract (is-same-tree p q)
  (-> (or/c null? tree-node?) (or/c null? tree-node?) boolean?)
  (cond
    [(and (null? p) (null? q)) #t]
    [(or (null? p) (null? q)) #f]
    [else
     (and (= (tree-node-val p) (tree-node-val q))
          (is-same-tree (tree-node-left p) (tree-node-left q))
          (is-same-tree (tree-node-right p) (tree-node-right q)))]))