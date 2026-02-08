(define (maximize-number-of-target-nodes root edges)
  (define (build-graph edges)
    (define graph (make-hash))
    (for-each (lambda (edge)
                (let ([u (car edge)]
                      [v (cadr edge)])
                  (hash-update! graph u (lambda (x) (cons v x)) '())
                  (hash-update! graph v (lambda (x) (cons u x)) '())))
              edges)
    graph)

  (define (find-roots edges)
    (define all-nodes (make-hash))
    (for-each (lambda (edge)
                (let ([u (car edge)]
                      [v (cadr edge)])
                  (hash-set! all-nodes u #t)
                  (hash-set! all-nodes v #t)))
              edges)
    (define all-children (make-hash))
    (for-each (lambda (edge)
                (let ([u (car edge)]
                      [v (cadr edge)])
                  (hash-set! all-children v #t)))
              edges)

    (filter (lambda (node) (not (hash-has-key? all-children node))) (hash-keys all-nodes)))

  (define (dfs root target graph visited)
    (cond [(null? root) 0]
          [(hash-ref visited root #f) 0]
          [else
           (hash-set! visited root #t)
           (let* ([is-target (if (equal? root target) 1 0)]
                  [neighbors (hash-ref graph root '())]
                  [max-children (apply + (map (lambda (neighbor) (dfs neighbor target graph visited)) neighbors))])
             (+ is-target max-children))]))

  (define graph (build-graph edges))
  (define roots (find-roots edges))
  (if (null? roots)
      0
      (apply max (map (lambda (root) (dfs root root graph (make-hash))) roots))))