(define/contract (find-target root k)
  (-> (or/c null? tree-node?) exact-integer? boolean?)
  (let ([seen (mutable-set)])
    (define (dfs node)
      (if (null? node)
          #f
          (let ([complement (- k (tree-node-val node))])
            (if (set-member? seen complement)
                #t
                (begin
                  (set-add! seen (tree-node-val node))
                  (or (dfs (tree-node-left node))
                      (dfs (tree-node-right node))))))))
    (dfs root)))