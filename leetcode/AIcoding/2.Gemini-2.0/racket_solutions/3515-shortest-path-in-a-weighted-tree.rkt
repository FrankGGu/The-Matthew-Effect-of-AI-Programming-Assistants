(define (shortest-path-length n edges source destination)
  (define adj (make-vector (add1 n) '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge))
                    (w (caddr edge)))
                (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
                (vector-set! adj v (cons (cons u w) (vector-ref adj v)))))
            edges)

  (define dist (make-vector (add1 n) +inf.0))
  (vector-set! dist source 0)

  (define pq (mutable-priority-queue <))
  (mutable-priority-queue-add! pq (cons 0 source))

  (let loop ()
    (if (mutable-priority-queue-empty? pq)
        -1
        (let* ((curr (mutable-priority-queue-remove! pq))
               (d (car curr))
               (u (cdr curr)))
          (if (> d (vector-ref dist u))
              (loop)
              (if (= u destination)
                  d
                  (begin
                    (for-each (lambda (neighbor)
                                (let ((v (car neighbor))
                                      (w (cdr neighbor)))
                                  (if (< (+ d w) (vector-ref dist v))
                                      (begin
                                        (vector-set! dist v (+ d w))
                                        (mutable-priority-queue-add! pq (cons (+ d w) v))))))
                              (vector-ref adj u))
                    (loop)))))))
)