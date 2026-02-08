(define (minimum-time-to-reach-last-room rooms seats)
  (define n (length rooms))
  (define dp (make-vector n 0))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 n)])
    (let* ([prev-time (vector-ref dp (- i 1))]
           [arrival-time (+ prev-time (vector-ref rooms (- i 1)))]
           [wait-time (if (>= arrival-time (vector-ref dp (- i 1)))
                          0
                          (- (vector-ref dp (- i 1)) arrival-time))]
           [departure-time (+ arrival-time wait-time)]
           [new-time (+ departure-time 1)])
      (vector-set! dp i new-time)))
  (vector-ref dp (- n 1)))