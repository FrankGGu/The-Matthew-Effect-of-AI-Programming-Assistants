(define (corp-flight-bookings bookings n)
  (let* ([result-vec (make-vector n 0)])
    (for-each (lambda (booking)
                (let* ([first (car booking)]
                       [last (cadr booking)]
                       [seats (caddr booking)])
                  (vector-set! result-vec (sub1 first) (+ (vector-ref result-vec (sub1 first)) seats))
                  (when (< last n)
                    (vector-set! result-vec last (- (vector-ref result-vec last) seats)))))
              bookings)

    (let loop ([i 1])
      (when (< i n)
        (vector-set! result-vec i (+ (vector-ref result-vec i) (vector-ref result-vec (sub1 i))))
        (loop (add1 i))))
    (vector->list result-vec)))