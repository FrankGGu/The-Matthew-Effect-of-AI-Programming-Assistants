(define (isSameAfterReversals(num))
  (define (reverse n)
    (string->number (list->string (reverse (string->list (number->string n))))))
  (equal? num (reverse (reverse num))))