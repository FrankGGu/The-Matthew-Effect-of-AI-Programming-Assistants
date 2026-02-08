(define (longest-cycle edges)
  (define n (length edges))
  (define visited (make-vector n #f))
  (define max-cycle -1)

  (define (dfs u start time dist)
    (cond
      [(= u start) (when (> time 1) (set! max-cycle (max max-cycle time)))]
      [(vector-ref visited u) (void)]
      [else
       (vector-set! visited u #t)
       (let ((v (list-ref edges u)))
         (when (not (= v -1))
           (dfs v start (+ time 1) (hash-set dist u time)))))]))

  (for ([u (in-range n)])
    (unless (vector-ref visited u)
      (define dist (make-hash))
      (dfs u u 0 dist))

  max-cycle)