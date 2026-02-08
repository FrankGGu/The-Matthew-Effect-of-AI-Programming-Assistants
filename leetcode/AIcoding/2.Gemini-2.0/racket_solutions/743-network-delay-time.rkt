(define (network-delay-time times n k)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (let ([u (car edge)]
                    [v (cadr edge)]
                    [w (caddr edge)])
                (hash-update! graph u (lambda (neighbors) (cons (list v w) neighbors)) '())))
            times)

  (define dist (make-vector (+ n 1) +inf.0))
  (vector-set! dist k 0)

  (define pq (make-heap <))
  (heap-add! pq (list 0 k))

  (define (relax u v w)
    (when (< (+ (vector-ref dist u) w) (vector-ref dist v))
      (vector-set! dist v (+ (vector-ref dist u) w))
      (heap-add! pq (list (vector-ref dist v) v))))

  (let loop ()
    (when (not (heap-empty? pq))
      (let* ([curr (heap-remove-min! pq)]
             [d (car curr)]
             [u (cadr curr)])
        (when (hash-has-key? graph u)
          (for-each (lambda (neighbor)
                      (let ([v (car neighbor)]
                            [w (cadr neighbor)])
                        (relax u v w)))
                    (hash-ref graph u))))
      (loop)))

  (define max-dist (apply max (vector->list (vector-tail dist 1))))
  (if (equal? max-dist +inf.0) -1 max-dist))