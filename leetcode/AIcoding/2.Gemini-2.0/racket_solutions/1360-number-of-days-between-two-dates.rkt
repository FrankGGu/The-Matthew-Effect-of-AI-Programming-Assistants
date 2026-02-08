(define (days-between-dates year1 month1 day1 year2 month2 day2)
  (define (is-leap-year? year)
    (cond
      [(and (= (modulo year 4) 0) (= (modulo year 100) 0) (= (modulo year 400) 0)) #t]
      [(and (= (modulo year 4) 0) (= (modulo year 100) 0)) #f]
      [(= (modulo year 4) 0) #t]
      [else #f]))

  (define (days-in-month year month)
    (cond
      [(= month 2) (if (is-leap-year? year) 29 28)]
      [(or (= month 4) (= month 6) (= month 9) (= month 11)) 30]
      [else 31]))

  (define (days-from-1971 year month day)
    (let loop ([year year] [month month] [day day] [total 0])
      (cond
        [(= year 1971)
         (let loop2 ([month month] [day day] [total total])
           (cond
             [(= month 1) (+ total day)]
             [else (loop2 (- month 1) day (+ total (days-in-month year (- month 1))))]))]
        [else (loop (- year 1) 12 31 (+ total (if (is-leap-year? (- year 1)) 366 365)))])))

  (abs (- (days-from-1971 year1 month1 day1) (days-from-1971 year2 month2 day2))))