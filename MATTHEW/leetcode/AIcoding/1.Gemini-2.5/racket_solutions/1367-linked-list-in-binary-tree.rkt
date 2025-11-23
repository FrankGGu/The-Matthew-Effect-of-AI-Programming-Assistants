(struct list-node (val next))
(struct tree-node (val left right))

(define (check-match list-ptr tree-ptr)
  (cond
    [(null? list-ptr) #t]
    [(null? tree-ptr) #f]
    [(!= (list-node-val list-ptr) (tree-node-val tree-ptr)) #f]
    [else (or (check-match (list-node-next list-ptr) (tree-node-left tree-ptr))
              (check-match (list-node-next list-ptr) (tree-node-right tree-ptr)))]))

(define (is-sub-path head root)
  (cond
    [(null? root) #f]
    [(check-match head root) #t]
    [else (or (is-sub-path head (tree-node-left root))
              (is-sub-path head (tree-node-right root)))]))