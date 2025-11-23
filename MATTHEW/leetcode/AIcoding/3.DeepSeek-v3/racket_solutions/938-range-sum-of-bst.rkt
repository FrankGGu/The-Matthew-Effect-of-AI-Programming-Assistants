(define/contract (range-sum-bst root low high)
  (-> (or/c null? tree-node?) exact-integer? exact-integer? exact-integer?)
  (if (null? root)
      0
      (let ([val (tree-node-val root)]
            [left (tree-node-left root)]
            [right (tree-node-right root)])
        (+ (if (and (>= val low) (<= val high)) val 0)
           (range-sum-bst left low high)
           (range-sum-bst right low high)))))