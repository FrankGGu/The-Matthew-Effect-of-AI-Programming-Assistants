(define (restoreArray adjacentPairs)
  (define graph (make-hash))
  (define count (make-hash))

  (for ([pair adjacentPairs])
    (let ([u (car pair)]
          [v (cadr pair)])
      (hash-update! graph u (lambda (lst) (cons v lst)) '())
      (hash-update! graph v (lambda (lst) (cons u lst)) '())
      (hash-update! count u add1 0)
      (hash-update! count v add1 0)))

  (define start (car (filter (lambda (k) (= (hash-ref count k) 1)) (hash-keys count))))

  (define result '())
  (define (dfs node prev)
    (set! result (cons node result))
    (for ([neighbor (hash-ref graph node)])
      (when (not (equal? neighbor prev))
        (dfs neighbor node))))

  (dfs start null)
  (reverse result))