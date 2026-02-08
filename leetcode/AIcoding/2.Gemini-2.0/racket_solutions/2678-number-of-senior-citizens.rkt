(define (count-seniors details)
  (define (is-senior? detail)
    (>= (string->number (substring detail 11 13)) 60))

  (length (filter is-senior? details)))