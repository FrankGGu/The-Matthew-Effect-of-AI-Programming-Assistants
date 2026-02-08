(define (insertion-sort-list l)
  (define (helper sorted unsorted)
    (cond
      [(null? unsorted) sorted]
      [else
       (define head (car unsorted))
       (define tail (cdr unsorted))
       (define (insert-helper sorted-so-far new-node)
         (cond
           [(null? sorted-so-far) (cons new-node null)]
           [(< (car new-node) (car sorted-so-far)) (cons new-node sorted-so-far)]
           [else (cons (car sorted-so-far) (insert-helper (cdr sorted-so-far) new-node))]))
       (helper (insert-helper sorted head) tail)]))
  (helper null l))