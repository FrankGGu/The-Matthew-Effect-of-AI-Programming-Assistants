(define (alternate-digit-sum n)
  (let loop ((n n) (sign 1) (sum 0))
    (if (= n 0)
        sum
        (loop (quotient n 10) (- sign) (+ sum (* sign (remainder n 10)))))))