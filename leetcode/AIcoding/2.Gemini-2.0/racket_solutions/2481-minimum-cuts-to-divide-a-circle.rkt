(define (number-of-cuts n)
  (cond
    [(zero? n) 0]
    [(odd? n) n]
    [else (/ n 2)]))