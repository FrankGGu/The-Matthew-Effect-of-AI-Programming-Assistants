(define (separate-digits nums)
  (apply append (map (lambda (n) (string->list (number->string n))) nums)))