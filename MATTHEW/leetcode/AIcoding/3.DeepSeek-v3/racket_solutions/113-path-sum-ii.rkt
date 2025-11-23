(define/contract (path-sum root targetSum)
  (-> (or/c null? tree-node?) exact-integer? (listof (listof exact-integer?)))
  (define (helper node current-path remaining)
    (cond
      [(null? node) null]
      [else
       (define new-remaining (- remaining (tree-node-val node)))
       (define new-path (append current-path (list (tree-node-val node))))
       (if (and (null? (tree-node-left node)) (null? (tree-node-right node)) (= new-remaining 0))
           (list new-path)
           (append (helper (tree-node-left node) new-path new-remaining)
                   (helper (tree-node-right node) new-path new-remaining)))]))
  (helper root '() targetSum))