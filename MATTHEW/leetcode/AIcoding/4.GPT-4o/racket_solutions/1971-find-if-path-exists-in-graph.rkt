(define (validPath n edges source destination)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (hash-set! graph u (cons v (hash-ref graph u '())))
              (hash-set! graph v (cons u (hash-ref graph v '())))))
            edges)

  (define (dfs node visited)
    (if (equal? node destination)
        #t
        (begin
          (set! visited (cons node visited))
          (for/or ([neighbor (hash-ref graph node '())])
            (and (not (member neighbor visited))
                 (dfs neighbor visited))))))

  (dfs source '()))