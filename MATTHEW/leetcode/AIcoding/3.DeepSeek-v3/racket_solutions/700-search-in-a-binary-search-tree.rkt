(define/contract (search-bst root val)
  (-> (or/c null? (list/c integer? (or/c null? (list/c integer? any/c any/c)) (or/c null? (list/c integer? any/c any/c)))) integer? (or/c null? (list/c integer? any/c any/c)))
  (cond
    [(null? root) null]
    [(= (car root) val) root]
    [(< val (car root)) (search-bst (cadr root) val)]
    [else (search-bst (caddr root) val)]))