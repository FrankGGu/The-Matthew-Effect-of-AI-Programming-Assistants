(define (is-sub-path head root)
  (define (dfs node path)
    (when node
      (define new-path (cons (node-value node) path))
      (if (equal? new-path (take new-path (length head)))
          #t
          (or (dfs (left node) new-path)
              (dfs (right node) new-path)))))
  (define (traverse node)
    (when node
      (or (dfs node '())
          (or (traverse (left node))
              (traverse (right node))))))
  (traverse root))