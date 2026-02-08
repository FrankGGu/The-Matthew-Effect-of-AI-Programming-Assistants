(define (min-time n edges has-apple)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define visited (make-vector n #f))

  (define (dfs u)
    (vector-set! visited u #t)
    (define total-time 0)
    (for ([v (vector-ref adj u)])
      (when (not (vector-ref visited v))
        (define child-time (dfs v))
        (when (or (> child-time 0) (vector-ref has-apple v))
          (set! total-time (+ total-time child-time 2))))
    total-time)

  (dfs 0))