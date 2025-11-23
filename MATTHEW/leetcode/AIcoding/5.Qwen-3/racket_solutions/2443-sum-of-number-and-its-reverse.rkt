(define (sum-of-number-and-its-reverse num)
  (define (reverse-number n)
    (string->number (list->string (reverse (string->list (number->string n))))))
  (+ num (reverse-number num)))