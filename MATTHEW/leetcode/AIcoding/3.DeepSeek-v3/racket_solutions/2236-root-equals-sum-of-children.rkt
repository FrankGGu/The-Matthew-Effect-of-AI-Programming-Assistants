(define/contract (check-tree root)
  (-> (or/c null? tree-node?) boolean?)
  (if (null? root)
      #t
      (let ([val (tree-node-val root)]
            [left (tree-node-left root)]
            [right (tree-node-right root)])
        (if (and (not (null? left)) (not (null? right)))
            (= val (+ (tree-node-val left) (tree-node-val right)))
            #f))))