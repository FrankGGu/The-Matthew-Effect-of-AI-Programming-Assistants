(define (find-numbers nums)
  (define (count-digits n)
    (if (zero? n)
        0
        (add1 (count-digits (quotient n 10)))))
  (define (even-digits? n)
    (even? (count-digits n)))
  (length (filter even-digits? nums)))