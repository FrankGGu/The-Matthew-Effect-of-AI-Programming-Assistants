(define (leaf-similar-trees root1 root2)
  (define (get-leaf-sequence root)
    (define (helper node acc)
      (cond
        [(null? node) acc]
        [(and (null? (left node)) (null? (right node))) (cons (value node) acc)]
        [else (append (helper (left node) acc) (helper (right node) acc))]))
    (reverse (helper root '())))

  (equal? (get-leaf-sequence root1) (get-leaf-sequence root2)))