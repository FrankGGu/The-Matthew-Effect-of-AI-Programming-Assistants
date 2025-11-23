(define (avoid-flood rains)
  (define n (length rains))
  (define result (make-vector n -1))
  (define lake (make-hash))
  (define available (list))

  (for ([i (in-range n)])
    (define rain-day (vector-ref rains i))
    (if (zero? rain-day)
      (begin
        (set! available (cons i available)))
      (begin
        (define lake-day (hash-ref lake rain-day #f))
        (if lake-day
          (if (null? available)
            (begin
              (set! result #f)
              (return))
            (let ([flood-day (car available)])
              (vector-set! result flood-day rain-day)
              (set! available (cdr available))))
          (hash-set! lake rain-day i)))))

  (for-each (lambda (day)
              (vector-set! result day 1))
            available)

  result)