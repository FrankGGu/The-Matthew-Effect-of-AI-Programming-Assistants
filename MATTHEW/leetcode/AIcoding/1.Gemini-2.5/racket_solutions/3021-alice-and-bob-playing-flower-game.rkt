(define (flowerGame n m)
  (+
   (* (quotient (+ n 1) 2) (quotient m 2))
   (* (quotient n 2) (quotient (+ m 1) 2))))