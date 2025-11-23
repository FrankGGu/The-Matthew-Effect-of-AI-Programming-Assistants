(define (busy-student start-time end-time query-time)
  (for/fold ([count 0])
            ([s start-time]
             [e end-time])
    (if (and (<= s query-time) (<= query-time e))
        (add1 count)
        count)))