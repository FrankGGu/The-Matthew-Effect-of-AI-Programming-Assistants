(define/contract (has-path-sum root targetSum)
  (-> (or/c null? tree-node?) exact-integer? boolean?)
  (cond
    [(null? root) #f]
    [(and (null? (tree-node-left root)) (null? (tree-node-right root)))
     (= targetSum (tree-node-val root))]
    [else
     (or (has-path-sum (tree-node-left root) (- targetSum (tree-node-val root)))
         (has-path-sum (tree-node-right root) (- targetSum (tree-node-val root))))]))