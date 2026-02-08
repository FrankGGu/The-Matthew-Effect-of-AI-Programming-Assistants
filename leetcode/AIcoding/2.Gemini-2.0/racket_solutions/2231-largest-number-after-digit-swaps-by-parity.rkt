(define (largest-number-after-digit-swaps-by-parity num)
  (define s (number->string num))
  (define evens (sort (filter (lambda (c) (even? (string->number (string c)))) (string->list s)) >))
  (define odds (sort (filter (lambda (c) (odd? (string->number (string c)))) (string->list s)) >))
  (define (helper lst evens odds)
    (cond
      [(empty? lst) '()]
      [(even? (string->number (string (car lst))))
       (cons (car evens) (helper (cdr lst) (cdr evens) odds))]
      [else
       (cons (car odds) (helper (cdr lst) evens (cdr odds)))]))
  (string->number (list->string (helper (string->list s) evens odds))))