(define (min-operations n)
  (if (even? n)
      (* (/ n 2) (/ n 2))
      (* (quotient n 2) (+ (quotient n 2) 1))))