(define (delete-node root key)
  (cond
    [(null? root) root]
    [(< key (car root)) (cons (car root) (cons (delete-node (cadr root) key) (cddr root)))]
    [(> key (car root)) (cons (car root) (cons (cadr root) (cons (delete-node (cddr root) key))))]
    [else
     (cond
       [(and (null? (cadr root)) (null? (cddr root))) null]
       [(null? (cadr root)) (cddr root)]
       [(null? (cddr root)) (cadr root)]
       [else
        (define (min-value-node node)
          (if (null? (cadr node))
              node
              (min-value-node (cadr node))))
        (define successor (min-value-node (cddr root)))
        (cons (car successor) (cons (cadr root) (cons (delete-node (cddr root) (car successor)))))]
       )]))