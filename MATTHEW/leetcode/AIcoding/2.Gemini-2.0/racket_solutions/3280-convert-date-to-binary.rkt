(define (convert-date date)
  (define month-map
    '((Jan . 1) (Feb . 2) (Mar . 3) (Apr . 4) (May . 5) (Jun . 6)
      (Jul . 7) (Aug . 8) (Sep . 9) (Oct . 10) (Nov . 11) (Dec . 12)))

  (define (parse-date date)
    (define parts (string-split date " "))
    (define day (string->number (substring (car parts) 0 (- (string-length (car parts)) 2))))
    (define month (cdr (assoc (string->symbol (cadr parts)) month-map)))
    (define year (string->number (caddr parts)))
    (values day month year))

  (define-values (day month year) (parse-date date))
  (+ day (* 32 month) (* 416 year)))