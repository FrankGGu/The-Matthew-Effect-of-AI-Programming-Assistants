(define/contract (is-bipartite graph)
  (-> (listof (listof exact-integer?)) boolean?)
  (let ([n (length graph)]
        [color (make-vector n -1)])
    (define (dfs u c)
      (vector-set! color u c)
      (for ([v (in-list (list-ref graph u))])
        (cond
          [(= (vector-ref color v) -1)
           (when (not (dfs v (bitwise-xor c 1)))
             (return #f))]
          [(not (= (vector-ref color v) (bitwise-xor c 1)))
           (return #f)]))
      #t)
    (for ([u (in-range n)])
      (when (= (vector-ref color u) -1)
        (when (not (dfs u 0))
          (return #f))))
    #t))