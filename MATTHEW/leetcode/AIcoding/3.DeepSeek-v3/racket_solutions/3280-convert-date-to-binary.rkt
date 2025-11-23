(define/contract (date-to-binary date)
  (-> string? string?)
  (let* ([parts (string-split date "-")]
         [year (string->number (first parts))]
         [month (string->number (second parts))]
         [day (string->number (third parts))])
    (string-append
     (number->string year 2)
     (number->string month 2)
     (number->string day 2))))