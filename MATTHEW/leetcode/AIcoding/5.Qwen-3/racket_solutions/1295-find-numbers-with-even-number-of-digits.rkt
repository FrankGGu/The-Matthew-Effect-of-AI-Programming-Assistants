(define (find-num-of-even-digits nums)
  (define (even-digit? n)
    (even? (string-length (number->string n))))
  (length (filter even-digit? nums)))