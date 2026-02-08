(define (longest-cycle graph)
  (define n (vector-length graph))
  (define visited (make-vector n #f))
  (define path (make-vector n -1))
  (define max-len 0)

  (define (dfs u)
    (vector-set! visited u #t)
    (define v (vector-ref graph u))
    (when (and (>= v 0) (not (equal? (vector-ref path v) u)))
      (if (vector-ref visited v)
          (let loop ([curr v] [len 1])
            (cond
              [(equal? curr u)
               (set! max-len (max max-len len))]
              [else
               (loop (vector-ref graph curr) (+ len 1))]))
          (begin
            (vector-set! path v u)
            (dfs v)))))

  (for ([i (in-range n)])
    (unless (vector-ref visited i)
      (dfs i)))

  (if (> max-len 0) max-len -1))