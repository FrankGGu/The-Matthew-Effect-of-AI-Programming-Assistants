(define (count-visited-nodes graph start-node)
  (let* ([n (length graph)]
         [visited (make-vector n #f)]
         [path (make-vector n #f)]
         [result (make-vector n 0)])
    (define (dfs u)
      (vector-set! visited u #t)
      (vector-set! path u #t)
      (let ([v (vector-ref graph u)])
        (cond
          [(not (vector-ref visited v))
           (dfs v)
           (vector-set! result u (add1 (vector-ref result v)))]
          [(vector-ref path v)
           (let loop ([curr u] [count 1])
             (vector-set! result curr count)
             (if (= curr v)
                 #t
                 (loop (vector-ref graph curr) (add1 count))))
           (vector-set! result u (vector-ref result u))]
          [else
           (vector-set! result u (add1 (vector-ref result v)))]))
      (vector-set! path u #f))
    (for ([i (in-range n)])
      (when (not (vector-ref visited i))
        (dfs i)))
    (vector->list result)))

(define (count-visited-nodes-leet graph)
  (let ([n (length graph)])
    (map (λ (i) (count-visited-nodes graph i)) (range n))))