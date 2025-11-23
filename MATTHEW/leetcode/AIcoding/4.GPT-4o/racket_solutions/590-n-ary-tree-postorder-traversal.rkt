(define (postorder nary-tree)
  (define (traverse node)
    (if (null? node)
        '()
        (append (apply append (map traverse (nary-tree-children node)))
                (list (nary-tree-value node)))))
  (traverse nary-tree))

(define (nary-tree-value tree)
  (car tree))

(define (nary-tree-children tree)
  (cadr tree))