(define (count-odds low high)
  (if (= (modulo low 2) 1) ; If low is odd
      (+ (quotient (- high low) 2) 1)
      ; If low is even
      (quotient (+ (- high low) 1) 2)))