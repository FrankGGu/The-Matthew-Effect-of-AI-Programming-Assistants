(define (trailing-zeroes n)
  (if (< n 5)
      0
      (+ (quotient n 5) (trailing-zeroes (quotient n 5)))))