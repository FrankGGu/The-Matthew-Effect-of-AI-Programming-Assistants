(define (count-days-spent-together aliceArrival aliceDeparture bobArrival bobDeparture)
  (define days-in-month (list 0 31 28 31 30 31 30 31 31 30 31 30 31))

  (define (date-to-day-of-year date-str)
    (define parts (string-split date-str "-"))
    (define month (string->number (list-ref parts 0)))
    (define day (string->number (list-ref parts 1)))
    (define prev-months-days
      (for/sum ([i (in-range 1 month)])
        (list-ref days-in-month i)))
    (+ prev-months-days day))

  (define alice-arrival-day (date-to-day-of-year aliceArrival))
  (define alice-departure-day (date-to-day-of-year aliceDeparture))
  (define bob-arrival-day (date-to-day-of-year bobArrival))
  (define bob-departure-day (date-to-day-of-year bobDeparture))

  (define intersect-start (max alice-arrival-day bob-arrival-day))
  (define intersect-end (min alice-departure-day bob-departure-day))

  (if (<= intersect-start intersect-end)
      (+ (- intersect-end intersect-start) 1)
      0))