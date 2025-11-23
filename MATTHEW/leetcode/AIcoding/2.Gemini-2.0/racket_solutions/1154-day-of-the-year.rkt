(define (day-of-year year month day)
  (define (leap-year? year)
    (or (and (= (modulo year 4) 0)
             (not (= (modulo year 100) 0)))
        (= (modulo year 400) 0)))

  (define days-in-month
    (vector 31 (if (leap-year? year) 29 28) 31 30 31 30 31 31 30 31 30 31))

  (let loop ((m 1) (days 0))
    (if (< m month)
        (loop (+ m 1) (+ days (vector-ref days-in-month (- m 1))))
        (+ days day))))