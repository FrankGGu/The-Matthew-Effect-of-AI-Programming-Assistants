(define (base-neg2 n)
  (if (zero? n)
      "0"
      (let loop ((n n) (acc ""))
        (if (zero? n)
            acc
            (loop (quotient (- n (remainder n -2)) -2)
                  (string-append (number->string (remainder n -2)) acc))))))