(define (count-1 n)
  (define (count-1-helper n)
    (if (= n 0)
        0
        (+ (remainder n 10) (count-1-helper (quotient n 10)))))
  (count-1-helper n))