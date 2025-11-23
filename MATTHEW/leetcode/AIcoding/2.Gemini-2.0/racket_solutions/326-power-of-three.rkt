(define (power-of-three? n)
  (cond
    [(<= n 0) #f]
    [(= n 1) #t]
    [(zero? (remainder n 3)) (power-of-three? (quotient n 3))]
    [else #f]))