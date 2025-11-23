(define (restoreArray adjacentPairs)
  (define adj-map (make-hash))
  (for ([pair adjacentPairs])
    (let ([u (first pair)] [v (second pair)])
      (hash-update! adj-map u (lambda (x) (if x (cons v x) (list v))) '())
      (hash-update! adj-map v (lambda (x) (if x (cons u x) (list u))) '()))
    )

  (define start (car (filter (lambda (k) (= (length (hash-ref adj-map k)) 1)) (hash-keys adj-map))))

  (define result (list start))
  (define visited (make-hash))
  (hash-set! visited start #t)

  (letrec ([dfs (lambda (u)
                    (for ([v (hash-ref adj-map u)])
                      (when (not (hash-ref visited v #f))
                        (hash-set! visited v #t)
                        (set! result (append result (list v)))
                        (dfs v))))])
    (dfs start))

  (list->vector result))