(define/contract (del-nodes root to-delete)
  (-> (or/c null? tree-node?) (listof exact-integer?) (listof (or/c null? tree-node?)))
  (let ([to-delete-set (list->set to-delete)])
    (let loop ([node root] [is-root? #t])
      (cond
        [(null? node) null]
        [else
         (let* ([should-delete (set-member? to-delete-set (tree-node-val node))]
                [left (loop (tree-node-left node) should-delete)]
                [right (loop (tree-node-right node) should-delete)]
                [new-node (if should-delete
                             null
                             (tree-node (tree-node-val node) left right))])
           (if (and (not should-delete) is-root?)
               (cons new-node (append left right))
               (append left right)))]))))