(define (minimum-weighted-subgraph-with-required-paths n edges src1 src2 dest)
  (define adj (make-vector n null))
  (define adj-rev (make-vector n null))
  (for-each (lambda (edge)
              (let ([u (car edge)]
                    [v (cadr edge)]
                    [w (caddr edge)])
                (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
                (vector-set! adj-rev v (cons (cons u w) (vector-ref adj-rev v)))))
            edges)

  (define (dijkstra adj start)
    (define dist (make-vector n +inf.0))
    (vector-set! dist start 0.0)
    (define pq (make-heap < #:key (lambda (x) (vector-ref dist (car x)))))
    (heap-add! pq (cons start 0))

    (let loop ()
      (when (not (heap-empty? pq))
        (let* ([u-dist (heap-remove-min! pq)]
               [u (car u-dist)]
               [d (vector-ref dist u)])
          (when (> d (cdr u-dist)) (loop))
          (for-each (lambda (edge)
                      (let ([v (car edge)]
                            [w (cdr edge)])
                        (let ([new-dist (+ d w)])
                          (when (< new-dist (vector-ref dist v))
                            (vector-set! dist v new-dist)
                            (heap-add! pq (cons v new-dist))))))
                    (vector-ref adj u))
          (loop))))
    dist)

  (define dist-src1 (dijkstra adj src1))
  (define dist-src2 (dijkstra adj src2))
  (define dist-dest (dijkstra adj dest))
  (define dist-dest-rev (dijkstra adj-rev dest))

  (define min-weight +inf.0)
  (for ([i (in-range n)])
    (let ([weight (+ (vector-ref dist-src1 i)
                     (vector-ref dist-src2 i)
                     (vector-ref dist-dest-rev i))])
      (when (< weight min-weight)
        (set! min-weight weight))))

  (if (equal? min-weight +inf.0) -1 (inexact->exact (round min-weight))))