(define (mySqrt x)
  (define (helper low high)
    (if (> low high)
        high
        (let ((mid (quotient (+ low high) 2)))
          (cond
            ((= (* mid mid) x) mid)
            ((< (* mid mid) x) (helper (+ mid 1) high))
            (else (helper low (- mid 1))))))
    )
  (if (< x 2)
      x
      (helper 1 x)))