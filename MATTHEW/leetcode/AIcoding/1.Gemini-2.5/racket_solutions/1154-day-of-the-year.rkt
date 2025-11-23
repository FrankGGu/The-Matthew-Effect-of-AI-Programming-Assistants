(define (day-of-year date)
  (let* ([parts (string-split date "-")]
         [year (string->number (list-ref parts 0))]
         [month (string->number (list-ref parts 1))]
         [day (string->number (list-ref parts 2))]
         [days-in-month (list 0 31 28 31 30 31 30 31 31 30 31 30 31)]
         [is-leap-year (or (and (= (remainder year 4) 0)
                                (not (= (remainder year 100) 0)))
                           (= (remainder year 400) 0))])
    (let loop ([m 1] [total-days 0])
      (if (= m month)
          (+ total-days day)
          (loop (+ m 1)
                (+ total-days
                   (if (and (= m 2) is-leap-year)
                       29
                       (list-ref days-in-month m))))))))