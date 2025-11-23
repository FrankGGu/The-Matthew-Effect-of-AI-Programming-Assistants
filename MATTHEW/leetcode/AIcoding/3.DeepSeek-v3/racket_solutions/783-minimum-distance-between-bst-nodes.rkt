(define/contract (min-diff-in-bst root)
  (-> (or/c null? tree-node?) exact-integer?)
  (define-values (prev min-diff)
    (let loop ([node root] [prev #f] [min-diff +inf.0])
      (if (null? node)
          (values prev min-diff)
          (let*-values ([(prev min-diff) (loop (tree-node-left node) prev min-diff)]
                       [(new-min-diff) (if prev (min min-diff (- (tree-node-val node) prev)) min-diff)]
                       [(prev) (tree-node-val node)]
                       [(prev min-diff) (loop (tree-node-right node) prev new-min-diff)])
            (values prev min-diff)))))
  (inexact->exact (floor min-diff)))