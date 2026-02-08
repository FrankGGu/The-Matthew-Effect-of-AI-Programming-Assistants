(define (find-circle-num isConnected)
  (define n (length isConnected))
  (define visited (make-vector n #f))
  (define num-provinces 0)

  (define (dfs city)
    (vector-set! visited city #t)
    (for ([neighbor (in-range n)])
      (when (and (= (list-ref (list-ref isConnected city) neighbor) 1)
                 (not (vector-ref visited neighbor)))
        (dfs neighbor))))

  (for ([i (in-range n)])
    (when (not (vector-ref visited i))
      (set! num-provinces (+ num-provinces 1))
      (dfs i)))

  num-provinces)