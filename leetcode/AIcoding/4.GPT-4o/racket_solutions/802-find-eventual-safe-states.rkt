(define (eventualSafeNodes graph)
  (define n (length graph))
  (define visited (make-vector n #f))
  (define safe (make-vector n #f))

  (define (dfs node)
    (cond
      [(vector-ref visited node) (vector-ref safe node)]
      [else
       (vector-set! visited node #t)
       (define isSafe #t)
       (for ([neighbor (vector-ref graph node)])
         (when (not (dfs neighbor))
           (set! isSafe #f)))
       (vector-set! safe node isSafe)
       isSafe]))

  (for ([i (in-range n)])
    (dfs i))

  (define result '())
  (for ([i (in-range n)])
    (when (vector-ref safe i)
      (set! result (cons i result))))

  (reverse result))