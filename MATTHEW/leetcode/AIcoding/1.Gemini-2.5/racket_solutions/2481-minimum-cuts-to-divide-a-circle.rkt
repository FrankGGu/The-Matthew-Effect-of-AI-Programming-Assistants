(define (number-of-cuts n)
  (cond
    [(= n 1) 0]
    [(even? n) (/ n 2)]
    [else n]))