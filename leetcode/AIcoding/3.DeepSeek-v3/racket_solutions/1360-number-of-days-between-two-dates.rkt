(define (days-between-dates date1 date2)
  (define (parse-date date)
    (let* ([parts (string-split date "-")]
           [year (string->number (first parts))]
           [month (string->number (second parts))]
           [day (string->number (third parts))])
      (list year month day)))

  (define (date->days date)
    (let ([year (first date)]
          [month (second date)]
          [day (third date)])
      (let ([y (- year (if (< month 3) 1 0))]
            [m (+ month (if (< month 3) 9 -3))])
        (+ (* 365 y)
           (quotient y 4)
           (- (quotient y 100))
           (quotient y 400)
           (quotient (* 153 m + 2) 5)
           day -1))))

  (let ([d1 (parse-date date1)]
        [d2 (parse-date date2)])
    (abs (- (date->days d1) (date->days d2))))