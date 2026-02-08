(define (course-schedule-iv n prerequisites queries)
  (define reachable (build-vector n (lambda (i) (make-vector n #f))))

  (for ([i (in-range n)])
    (vector-set! (vector-ref reachable i) i #t))

  (for ([p prerequisites])
    (define u (car p))
    (define v (cadr p))
    (vector-set! (vector-ref reachable u) v #t))

  (for ([k (in-range n)])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (and (vector-ref (vector-ref reachable i) k)
                   (vector-ref (vector-ref reachable k) j))
          (vector-set! (vector-ref reachable i) j #t)))))

  (for/list ([q queries])
    (define u (car q))
    (define v (cadr q))
    (vector-ref (vector-ref reachable u) v)))