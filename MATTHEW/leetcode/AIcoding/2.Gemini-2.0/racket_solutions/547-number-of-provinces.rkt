(define (find-circle-num is-connected)
  (define n (vector-length is-connected))
  (define visited (make-vector n #f))
  (define count 0)

  (define (dfs u)
    (vector-set! visited u #t)
    (for/list ([v (in-range n)])
      (when (and (vector-ref (vector-ref is-connected u) v)
                 (not (vector-ref visited v)))
        (dfs v))))

  (for/list ([i (in-range n)])
    (when (not (vector-ref visited i))
      (set! count (+ count 1))
      (dfs i)))

  count)