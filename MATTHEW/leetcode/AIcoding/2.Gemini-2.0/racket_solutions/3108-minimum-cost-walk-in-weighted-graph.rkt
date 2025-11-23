(define (min-cost-walk n edges start end)
  (define adj (make-vector (add1 n) '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge))
                    (w (caddr edge)))
                (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
                (vector-set! adj v (cons (cons u w) (vector-ref adj v)))))
            edges)

  (define (dijkstra start end)
    (define dist (make-vector (add1 n) +inf.0))
    (vector-set! dist start 0.0)
    (define pq (mutable-priority-queue <))
    (enqueue! pq (cons 0.0 start))

    (define (process)
      (if (empty-queue? pq)
          #f
          (let* ((curr (dequeue! pq))
                 (d (car curr))
                 (u (cdr curr)))
            (if (> d (vector-ref dist u))
                (process)
                (begin
                  (for-each (lambda (neighbor)
                              (let ((v (car neighbor))
                                    (w (cdr neighbor)))
                                (if (< (+ d w) (vector-ref dist v))
                                    (begin
                                      (vector-set! dist v (+ d w))
                                      (enqueue! pq (cons (+ d w) v)))))
                            (vector-ref adj u))
                  (process))))))

    (process)
    (if (= (vector-ref dist end) +inf.0)
        -1
        (inexact->exact (vector-ref dist end))))

  (dijkstra start end))