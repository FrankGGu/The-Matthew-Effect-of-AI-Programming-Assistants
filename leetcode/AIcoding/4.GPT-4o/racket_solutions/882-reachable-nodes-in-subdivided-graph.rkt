(define (reachable-nodes edges maxMoves start)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (define w (caddr edge))
              (hash-set! graph u (cons (cons v w) (hash-ref graph u '())))
              (hash-set! graph v (cons (cons u w) (hash-ref graph v '())))))
            edges)

  (define visited (make-hash))
  (define (dfs node moves)
    (if (or (>= moves 0) (hash-ref visited node #f))
        (begin
          (hash-set! visited node #t)
          (for-each (lambda (neighbor)
                      (define next-node (car neighbor))
                      (define weight (cdr neighbor))
                      (dfs next-node (- moves weight)))
                    (hash-ref graph node '())))))

  (dfs start maxMoves)

  (define reachable (hash-count visited))
  (for/fold ([total reachable]) ([u (hash-keys graph)])
    (+ total (if (hash-ref visited u #f)
                 0
                 (for/fold ([sum 0]) ([v (hash-ref graph u '())])
                   (+ sum (min (cdr v) (maxMoves - (hash-ref visited v #f))))))))

  reachable)