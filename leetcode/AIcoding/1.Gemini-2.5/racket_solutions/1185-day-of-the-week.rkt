(define (day-of-the-week day month year)
  (define (is-leap-year? y)
    (or (and (= (modulo y 4) 0) (not (= (modulo y 100) 0)))
        (= (modulo y 400) 0)))

  (define days-of-week (vector "Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"))

  (define days-in-month-non-leap (vector 0 31 28 31 30 31 30 31 31 30 31 30 31))
  (define days-in-month-leap (vector 0 31 29 31 30 31 30 31 31 30 31 30 31))

  (let ([total-days 0])
    (for ([y (range 1971 year)])
      (set! total-days (+ total-days (if (is-leap-year? y) 366 365))))

    (let ([current-year-days-in-month (if (is-leap-year? year)
                                          days-in-month-leap
                                          days-in-month-non-leap)])
      (for ([m (range 1 month)])
        (set! total-days (+ total-days (vector-ref current-year-days-in-month m)))))

    (set! total-days (+ total-days (- day 1)))

    (vector-ref days-of-week (modulo (+ 5 total-days) 7))))