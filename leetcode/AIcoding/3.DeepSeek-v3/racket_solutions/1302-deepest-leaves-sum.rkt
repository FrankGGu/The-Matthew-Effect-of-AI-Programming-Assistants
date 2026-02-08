(define/contract (deepest-leaves-sum root)
  (-> (or/c null? tree-node?) exact-integer?)
  (define (max-depth node)
    (if (null? node)
        0
        (+ 1 (max (max-depth (tree-node-left node))
                  (max-depth (tree-node-right node)))))
  (define target-depth (max-depth root))
  (define (sum-at-depth node depth)
    (cond [(null? node) 0]
          [(= depth target-depth) (tree-node-val node)]
          [else (+ (sum-at-depth (tree-node-left node) (+ depth 1))
                   (sum-at-depth (tree-node-right node) (+ depth 1)))]))
  (sum-at-depth root 1))