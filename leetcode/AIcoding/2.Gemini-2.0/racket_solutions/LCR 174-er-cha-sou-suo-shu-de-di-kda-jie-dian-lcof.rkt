(define (searchBST root val)
  (cond
    [(null? root) #f]
    [(= (car root) val) root]
    [(< val (car root)) (searchBST (cadr root) val)]
    [else (searchBST (caddr root) val)]))