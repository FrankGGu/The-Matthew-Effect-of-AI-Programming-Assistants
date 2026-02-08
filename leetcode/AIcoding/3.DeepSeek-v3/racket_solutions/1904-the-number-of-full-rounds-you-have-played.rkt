(define (number-of-rounds login-time logout-time)
  (define (time->minutes time)
    (let* ([parts (string-split time ":")]
           [hours (string->number (first parts))]
           [minutes (string->number (second parts))])
      (+ (* hours 60) minutes)))

  (let* ([login (time->minutes login-time)]
         [logout (time->minutes logout-time)]
         [adjusted-login (if (< logout login) (+ logout (* 24 60)) logout)]
         [start (ceiling (/ login 15))]
         [end (floor (/ adjusted-login 15))])
    (max 0 (- end start))))