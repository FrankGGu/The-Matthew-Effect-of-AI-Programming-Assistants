(define (path-existence-queries graph n queries)
  (define adj (make-vector (add1 n) '()))
  (for ([edge graph])
    (vector-set! adj (first edge) (cons (list (second edge) (third edge)) (vector-ref adj (first edge)))))

  (define (dijkstra start end)
    (define dist (make-vector (add1 n) +inf.0))
    (vector-set! dist start 0.0)
    (define pq (mutable-priority-queue #:priority (lambda (x) (vector-ref dist x))))
    (priority-queue-add! pq start)

    (let loop ()
      (if (priority-queue-empty? pq)
          +inf.0
          (let* ([u (priority-queue-remove! pq)]
                 [d (vector-ref dist u)])
            (if (= u end)
                d
                (begin
                  (for ([neighbor (vector-ref adj u)])
                    (let ([v (first neighbor)]
                          [weight (second neighbor)])
                      (if (< (+ d weight) (vector-ref dist v))
                          (begin
                            (vector-set! dist v (+ d weight))
                            (priority-queue-add! pq v))))))
                  (loop))))))
    )

  (map (lambda (query)
         (let ([start (first query)]
               [end (second query)])
           (let ([distance (dijkstra start end)])
             (if (equal? distance +inf.0)
                 -1
                 distance))))
       queries))