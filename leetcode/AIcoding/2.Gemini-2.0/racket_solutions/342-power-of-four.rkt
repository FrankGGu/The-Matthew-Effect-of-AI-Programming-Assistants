(define (power-of-four? n)
  (and (positive? n)
       (integer? (log n 4))))