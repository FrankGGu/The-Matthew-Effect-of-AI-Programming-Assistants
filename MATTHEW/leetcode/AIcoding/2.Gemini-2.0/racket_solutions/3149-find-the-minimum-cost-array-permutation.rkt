(define (min-cost-permutation cost)
  (define n (vector-length cost))
  (define visited (make-vector n #f))
  (define (dfs u)
    (vector-set! visited u #t)
    (let loop ([v 0] [min-val +inf.0])
      (cond
        [(= v n) min-val]
        [(or (vector-ref cost u v) (vector-ref visited v))
         (loop (+ v 1) min-val)]
        [else
         (loop (+ v 1) (min min-val (vector-ref cost u v)))])))
  (define (solve)
    (let loop ([u 0] [total-cost 0.0])
      (cond
        [(= u n) total-cost]
        [(vector-ref visited u) (loop (+ u 1) total-cost)]
        [else
         (let ([min-val (dfs u)])
           (loop (+ u 1) (+ total-cost min-val)))])))
  (solve))