(define (alternating-digit-sum n)
  (define (helper n sign)
    (if (= n 0)
        0
        (+ (* sign (remainder n 10)) (helper (quotient n 10) (- sign)))))
  (helper n 1))