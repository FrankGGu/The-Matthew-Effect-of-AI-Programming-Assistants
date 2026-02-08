(define (minimum-operations num1 num2)
  (define diff (abs (- num1 num2)))
  (if (zero? diff)
      0
      (+ (quotient diff 5)
         (quotient (remainder diff 5) 2)
         (remainder (remainder diff 5) 2))))