(define (change-data-type data)
  (cond
    [(string? data) (string->number data)]
    [(number? data) (number->string data)]
    [else data]))