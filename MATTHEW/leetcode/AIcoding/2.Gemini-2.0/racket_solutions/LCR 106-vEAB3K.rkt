(define (is-bipartite graph)
  (define n (length graph))
  (define colors (make-vector n 0))

  (define (dfs u color)
    (vector-set! colors u color)
    (for/and ([v (in-list (vector-ref graph u))])
      (cond
        [(= (vector-ref colors v) 0)
         (dfs v (- 3 color))]
        [(= (vector-ref colors v) color)
         #f]
        [else
         #t])))

  (for/and ([i (in-range n)]
            #:when (= (vector-ref colors i) 0))
    (dfs i 1)))