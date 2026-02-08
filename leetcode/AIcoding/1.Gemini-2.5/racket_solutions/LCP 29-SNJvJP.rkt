(define (orchestra-seat num x y)
  (+ 1 (min x y (- num 1 x) (- num 1 y))))