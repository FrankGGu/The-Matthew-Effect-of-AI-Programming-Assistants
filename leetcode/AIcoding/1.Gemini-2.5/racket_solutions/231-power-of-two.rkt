(define (is-power-of-two n)
  (and (> n 0) (= (bitwise-and n (- n 1)) 0)))