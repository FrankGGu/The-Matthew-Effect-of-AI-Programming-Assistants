(define (countIntegers low high)
  (if (< low high)
      (- high low)
      0))

(define (countIntegersWrapper low high)
  (countIntegers low high))