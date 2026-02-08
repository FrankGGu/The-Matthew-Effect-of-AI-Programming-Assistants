(define (mySqrt x)
  (define (helper low high)
    (if (> low high)
        high
        (define mid (quotient (+ low high) 2))
        (if (<= (* mid mid) x)
            (helper (+ mid 1) high)
            (helper low (- mid 1)))))
  (if (zero? x) 0 (helper 1 x)))