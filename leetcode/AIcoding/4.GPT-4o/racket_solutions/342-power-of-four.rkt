(define (isPowerOfFour n)
  (and (> n 0) (zero? (modulo (log n 4) 1))))