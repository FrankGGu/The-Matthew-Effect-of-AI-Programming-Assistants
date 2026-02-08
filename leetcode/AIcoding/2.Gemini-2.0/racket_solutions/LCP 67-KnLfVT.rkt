(define (decorate-tree root values)
  (define (inorder-traversal node values idx)
    (cond
      [(null? node) (values idx)]
      [else
       (let* ([left-res (inorder-traversal (car node) values idx)]
              [new-val (car left-res)]
              [new-values (cdr left-res)]
              [right-res (inorder-traversal (cadr node) new-values (+ idx 1))])
         (cons new-val (cdr right-res)))]))

  (define (tree->list root)
    (cond
      [(null? root) '()]
      [else (append (tree->list (car root)) (list (cadr root)) (tree->list (cadr root)))]))

  (define (list->tree lst root)
    (cond
      [(null? root) null]
      [else
       (let* ([left-res (list->tree lst (car root))]
              [left-lst (car left-res)]
              [right-res (list->tree (cdr left-lst) (cadr root))])
         (cons left-lst right-res))]))

  (define lst (tree->list root))
  (define len (length lst))
  (define new-values (make-vector len 0))
  (for ((i (in-range len)))
    (vector-set! new-values i (list-ref values i)))

  (define result (inorder-traversal root new-values 0))
  (define new-tree (list->tree (cdr result) root))
  (cadr new-tree))