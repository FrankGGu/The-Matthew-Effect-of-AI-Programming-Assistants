(define (find-numbers nums)
  (define (count-digits n)
    (string-length (number->string n)))

  (define (even-digits? n)
    (even? (count-digits n)))

  (count even-digits? nums))