(define (find-numbers nums)
  (length (filter (lambda (n) (even? (string-length (number->string n)))) nums)))