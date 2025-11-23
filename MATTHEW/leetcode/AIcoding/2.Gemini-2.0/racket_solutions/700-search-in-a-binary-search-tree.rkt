(define (searchBST root val)
  (cond
    [(null? root) null]
    [(< val (struct-ref root 0)) (searchBST (struct-ref root 1) val)]
    [(> val (struct-ref root 0)) (searchBST (struct-ref root 2) val)]
    [else root]))