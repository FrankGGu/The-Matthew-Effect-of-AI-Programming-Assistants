(define (minimum-weighted-subgraph-with-the-required-paths n edges src1 src2 dest)
  (define graph (make-hash))
  (define rev-graph (make-hash))

  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge))
                    (w (caddr edge)))
                (hash-update! graph u (lambda (val) (cons (cons v w) val)) '())
                (hash-update! rev-graph v (lambda (val) (cons (cons u w) val)) '())))
            edges)

  (define (dijkstra graph start)
    (define dist (make-vector n +inf.0))
    (vector-set! dist start 0.0)

    (define pq (make-heap < #:key (lambda (x) (vector-ref dist x))))
    (heap-add! pq start)

    (let loop ()
      (if (heap-empty? pq)
          dist
          (let* ((u (heap-remove-min! pq))
                 (neighbors (hash-ref graph u '())))
            (for-each (lambda (neighbor)
                        (let ((v (car neighbor))
                              (w (cdr neighbor)))
                          (if (< (+ (vector-ref dist u) w) (vector-ref dist v))
                              (begin
                                (vector-set! dist v (+ (vector-ref dist u) w))
                                (heap-add! pq v)))))
                      neighbors)
            (loop))))

  (define dist-src1 (dijkstra graph src1))
  (define dist-src2 (dijkstra graph src2))
  (define dist-dest (dijkstra rev-graph dest))

  (define min-weight +inf.0)

  (for ([i (in-range n)])
    (set! min-weight (min min-weight (+ (vector-ref dist-src1 i) (vector-ref dist-src2 i) (vector-ref dist-dest i)))))

  (if (equal? min-weight +inf.0)
      -1
      min-weight))