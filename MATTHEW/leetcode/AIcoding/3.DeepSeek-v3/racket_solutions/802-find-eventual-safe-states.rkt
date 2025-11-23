(define (eventual-safe-nodes graph)
  (define n (length graph))
  (define color (make-vector n 0)) ; 0: unvisited, 1: visiting, 2: safe

  (define (is-safe node)
    (cond
      [(= (vector-ref color node) 1] #f
      [(= (vector-ref color node) 2] #t
      [else
       (vector-set! color node 1)
       (define safe #t)
       (for ([neighbor (list-ref graph node)])
         (unless (is-safe neighbor)
           (set! safe #f)))
       (vector-set! color node (if safe 2 0))
       safe]))

  (for/list ([i (in-range n)] #:when (is-safe i)) i))