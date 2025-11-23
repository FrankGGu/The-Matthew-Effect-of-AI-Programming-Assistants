(define (thousandSeparator n)
  (define (helper num acc)
    (if (< num 1000)
        (if (null? acc) (number->string num) (string-append (number->string num) acc))
        (helper (quotient num 1000) (string-append (format "~a," (remainder num 1000)) acc))))
  (helper n ""))

(thousandSeparator 123456789) ; Example usage