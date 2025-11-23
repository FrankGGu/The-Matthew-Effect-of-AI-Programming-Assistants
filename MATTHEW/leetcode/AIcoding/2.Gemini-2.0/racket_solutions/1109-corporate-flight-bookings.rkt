(define (corp-flight-bookings bookings n)
  (let ((flights (make-vector n 0)))
    (for ([booking bookings])
      (let ([start (vector-ref booking 0)]
            [end (vector-ref booking 1)]
            [seats (vector-ref booking 2)])
        (for ([i (in-range (- start 1) end)])
          (vector-set! flights i (+ (vector-ref flights i) seats)))))
    (vector->list flights)))