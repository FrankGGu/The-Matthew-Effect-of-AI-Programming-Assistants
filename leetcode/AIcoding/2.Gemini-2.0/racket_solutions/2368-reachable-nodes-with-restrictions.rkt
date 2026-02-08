(define (reachable-nodes n edges restricted)
  (let* ([adj-list (make-vector n '())]
         [restricted-set (set restricted)]
         [visited (make-vector n #f)])
    (for ([edge edges])
      (let ([u (first edge)]
            [v (second edge)])
        (vector-set! adj-list u (cons v (vector-ref adj-list u)))
        (vector-set! adj-list v (cons u (vector-ref adj-list v)))))

    (define (dfs u)
      (if (or (vector-ref visited u) (set-member? restricted-set u))
          0
          (begin
            (vector-set! visited u #t)
            (+ 1 (foldl + 0 (map dfs (vector-ref adj-list u)))))))

    (dfs 0)))