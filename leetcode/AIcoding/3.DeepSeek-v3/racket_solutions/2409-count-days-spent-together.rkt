(define/contract (count-days-together arrive-alice leave-alice arrive-bob leave-bob)
  (-> string? string? string? string? exact-integer?)
  (define (parse-date date)
    (let* ([parts (string-split date "-")]
           [month (string->number (first parts))]
           [day (string->number (second parts))])
      (cons month day)))

  (define (date->days date)
    (let ([month (car date)]
          [day (cdr date)])
      (let loop ([m 1] [days 0])
        (if (= m month)
            (+ days day)
            (loop (+ m 1) (+ days (days-in-month m)))))))

  (define (days-in-month m)
    (cond
      [(= m 2) 28]
      [(or (= m 4) (= m 6) (= m 9) (= m 11)) 30]
      [else 31]))

  (let* ([alice-arrive (parse-date arrive-alice)]
         [alice-leave (parse-date leave-alice)]
         [bob-arrive (parse-date arrive-bob)]
         [bob-leave (parse-date leave-bob)]
         [alice-start (date->days alice-arrive)]
         [alice-end (date->days alice-leave)]
         [bob-start (date->days bob-arrive)]
         [bob-end (date->days bob-leave)]
         [start (max alice-start bob-start)]
         [end (min alice-end bob-end)])
    (max 0 (- end start -1))))