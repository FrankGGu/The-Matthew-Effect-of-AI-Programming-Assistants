(define (convert-date-to-binary date-string)
  (let* ([parts (string-split date-string "-")]
         [year (string->number (list-ref parts 0))]
         [month (string->number (list-ref parts 1))]
         [day (string->number (list-ref parts 2))]
         [date-integer (+ (* year 10000) (* month 100) day)])
    (number->string date-integer 2)))