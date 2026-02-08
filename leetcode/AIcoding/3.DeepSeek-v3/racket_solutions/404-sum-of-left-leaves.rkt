(define/contract (sum-of-left-leaves root)
  (-> (or/c null? tree-node?) exact-integer?)
  (define (helper node is-left)
    (if (null? node)
        0
        (if (and (null? (tree-node-left node)) (null? (tree-node-right node)) is-left)
            (tree-node-val node)
            (+ (helper (tree-node-left node) #t) (helper (tree-node-right node) #f)))))
  (helper root #f))