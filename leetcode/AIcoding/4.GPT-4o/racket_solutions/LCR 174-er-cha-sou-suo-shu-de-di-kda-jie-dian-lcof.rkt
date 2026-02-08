(define (search-bst root val)
  (cond
    [(null? root) #f]
    [(= (send root 'val) val) root]
    [(< val (send root 'val)) (search-bst (send root 'left) val)]
    [else (search-bst (send root 'right) val)]))