(define/contract (flip-equiv root1 root2)
  (-> (or/c #f tree-node?) (or/c #f tree-node?) boolean?)
  (cond
    [(and (not root1) (not root2)) #t]
    [(or (not root1) (not root2)) #f]
    [(not (= (tree-node-val root1) (tree-node-val root2))) #f]
    [else
     (or (and (flip-equiv (tree-node-left root1) (tree-node-left root2))
              (flip-equiv (tree-node-right root1) (tree-node-right root2)))
         (and (flip-equiv (tree-node-left root1) (tree-node-right root2))
              (flip-equiv (tree-node-right root1) (tree-node-left root2))))]))