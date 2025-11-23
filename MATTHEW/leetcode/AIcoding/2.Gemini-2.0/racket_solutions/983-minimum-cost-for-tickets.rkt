(define (mincostTickets days costs)
  (define (dp i)
    (cond
      [(>= i (length days)) 0]
      [else (min (+ (list-ref costs 0) (dp (+ i 1)))
                 (+ (list-ref costs 1) (dp (find-next-day days i 7)))
                 (+ (list-ref costs 2) (dp (find-next-day days i 30))))]))

  (define (find-next-day days i duration)
    (let loop ([j i])
      (cond
        [(>= j (length days)) (length days)]
        [(< (list-ref days j) (+ (list-ref days i) duration)) (loop (+ j 1))]
        [else j])))

  (dp 0))