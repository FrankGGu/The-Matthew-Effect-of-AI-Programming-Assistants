(define (shortest-distance queries n edges)
  (define adj (make-vector n (list)))
  (for ([edge edges])
    (let ([u (first edge)] [v (second edge)] [w (third edge)])
      (set! (vector-ref adj u) (cons (list v w) (vector-ref adj u)))
      (set! (vector-ref adj v) (cons (list u w) (vector-ref adj v)))))

  (define (dijkstra start added-edge)
    (let ([dist (make-vector n +inf.0)]
          [visited (make-vector n #f)])
      (vector-set! dist start 0.0)
      (define pq (mutable-priority-queue <))
      (mutable-priority-queue-add! pq (cons 0.0 start))
      (when added-edge
        (let ([u (first added-edge)] [v (second added-edge)] [w (third added-edge)])
            (set! (vector-ref adj u) (cons (list v w) (vector-ref adj u)))
            (set! (vector-ref adj v) (cons (list u w) (vector-ref adj v)))))

      (let loop ()
        (if (mutable-priority-queue-empty? pq)
            (begin
              (when added-edge
                (let ([u (first added-edge)] [v (second added-edge)])
                  (set! (vector-ref adj u) (filter (lambda (x) (not (equal? (first x) v))) (vector-ref adj u)))
                  (set! (vector-ref adj v) (filter (lambda (x) (not (equal? (first x) u))) (vector-ref adj v)))))
              dist)
            (let ([curr (mutable-priority-queue-remove! pq)])
              (let ([d (car curr)] [u (cdr curr)])
                (if (vector-ref visited u)
                    (loop)
                    (begin
                      (vector-set! visited u #t)
                      (for ([neighbor (vector-ref adj u)])
                        (let ([v (first neighbor)] [w (second neighbor)])
                          (if (< (+ d w) (vector-ref dist v))
                              (begin
                                (vector-set! dist v (+ d w))
                                (mutable-priority-queue-add! pq (cons (+ d w) v))))))
                      (loop)))))))

      loop))

  (define result (list))
  (for ([query queries])
    (let ([dist (dijkstra 0 query)])
      (let ([d (vector-ref dist (- n 1))])
        (set! result (cons (if (= d +inf.0) -1 (inexact->exact (floor d))) result)))))

  (reverse result))