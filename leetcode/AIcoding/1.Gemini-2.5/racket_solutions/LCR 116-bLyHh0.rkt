(define (find-circle-num isConnected)
  (let* ([n (length isConnected)]
         [visited (make-vector n #f)] ; #f for not visited, #t for visited
         [province-count 0])

    (define (dfs current-city)
      (vector-set! visited current-city #t)
      (let ([row (list-ref isConnected current-city)])
        (for ([neighbor (in-range n)])
          (when (and (= (list-ref row neighbor) 1)
                     (not (vector-ref visited neighbor)))
            (dfs neighbor)))))

    (for ([i (in-range n)])
      (when (not (vector-ref visited i))
        (set! province-count (+ province-count 1))
        (dfs i)))

    province-count))