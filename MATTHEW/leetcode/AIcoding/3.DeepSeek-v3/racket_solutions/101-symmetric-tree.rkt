(define/contract (is-symmetric root)
  (-> (or/c null? tree-node?) boolean?)
  (if (null? root)
      #t
      (letrec ([mirror? (lambda (left right)
                           (cond [(and (null? left) (null? right)) #t]
                                 [(or (null? left) (null? right)) #f]
                                 [else (and (equal? (tree-node-val left) (tree-node-val right))
                                            (mirror? (tree-node-left left) (tree-node-right right))
                                            (mirror? (tree-node-right left) (tree-node-left right)))]))])
        (mirror? (tree-node-left root) (tree-node-right root)))))