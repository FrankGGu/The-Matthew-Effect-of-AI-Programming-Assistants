(define/contract (sum-numbers root)
  (-> (or/c null? tree-node?) exact-integer?)
  (define (helper node current-sum)
    (if (null? node)
        0
        (let ([new-sum (+ (* current-sum 10) (tree-node-val node))])
          (if (and (null? (tree-node-left node)) (null? (tree-node-right node)))
              new-sum
              (+ (helper (tree-node-left node) new-sum)
                 (helper (tree-node-right node) new-sum))))))
  (helper root 0))