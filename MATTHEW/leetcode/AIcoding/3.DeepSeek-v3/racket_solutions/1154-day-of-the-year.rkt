(define (day-of-year date)
  (let* ([parts (string-split date "-")]
         [year (string->number (first parts))]
         [month (string->number (second parts))]
         [day (string->number (third parts))]
         [leap? (or (and (zero? (modulo year 4))
                         (not (zero? (modulo year 100))))
                    (zero? (modulo year 400)))]
         [days-in-month (list 31 (if leap? 29 28) 31 30 31 30 31 31 30 31 30 31)])
    (+ day (apply + (take days-in-month (- month 1))))))