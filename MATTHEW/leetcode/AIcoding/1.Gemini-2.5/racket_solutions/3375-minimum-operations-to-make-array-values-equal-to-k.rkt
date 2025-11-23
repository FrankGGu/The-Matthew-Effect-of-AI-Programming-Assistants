(define (min-operations nums k)
  (for/sum ([num (in-list nums)])
    (abs (- num k))))