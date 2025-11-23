(define (add-digits n)
  (if (< n 10)
      n
      (add-digits (modulo (+ (quotient n 10) (modulo n 10)) 10))))