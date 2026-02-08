(struct tree-node (val left right) #:transparent)

(define (insert-into-max-tree root val)
  (define new-node (tree-node val #f #f))
  (cond
    [(not root) new-node]
    [(> (tree-node-val root) val)
     (tree-node (tree-node-val root) (tree-node-left root) (insert-into-max-tree (tree-node-right root) val))]
    [else
     (tree-node val root #f)]))