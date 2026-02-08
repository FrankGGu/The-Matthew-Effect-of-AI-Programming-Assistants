(define/contract (level-order-bottom root)
  (-> (or/c null? tree-node?) (listof (listof exact-integer?)))
  (if (null? root)
      '()
      (let loop ([nodes (list root)]
                 [result '()])
        (if (null? nodes)
            (reverse result)
            (let-values ([(next-level current-level)
                          (for/fold ([next '()]
                                     [current '()])
                                    ([node (in-list nodes)])
                            (values (append next 
                                           (filter-not null? 
                                                      (list (tree-node-left node) 
                                                            (tree-node-right node))))
                                    (cons (tree-node-val node) current)))])
              (loop next-level (cons (reverse current-level) result)))))))