(define (concert-tickets groups)
  (define available-tickets (make-vector 1001 #f))
  (for ([i (in-range 1 1001)])
    (vector-set! available-tickets i #t))

  (define (book-tickets group-size)
    (define start (find-first (lambda (x) (and (vector-ref available-tickets x)
                                               (<= x (- 1000 group-size))))
                               (in-range 1 1001)))
    (if start
        (begin
          (for ([i (in-range start (+ start group-size))])
            (vector-set! available-tickets i #f))
          start)
        -1))

  (map book-tickets groups))