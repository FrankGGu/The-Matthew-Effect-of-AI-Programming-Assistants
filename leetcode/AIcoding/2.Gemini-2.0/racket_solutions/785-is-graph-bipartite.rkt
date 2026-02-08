(define (is-bipartite graph)
  (let* ((n (length graph))
         (colors (make-vector n 0)))
    (define (dfs u color)
      (vector-set! colors u color)
      (for/and ((v (in-list (list-ref graph u))))
               (cond
                 ((= (vector-ref colors v) 0)
                  (dfs v (- 3 color)))
                 ((= (vector-ref colors v) color)
                  #f)
                 (else
                  #t))))
    (let loop ((u 0))
      (cond
        ((= u n) #t)
        ((not (= (vector-ref colors u) 0)) (loop (+ u 1)))
        ((dfs u 1) (loop (+ u 1)))
        (else #f)))))