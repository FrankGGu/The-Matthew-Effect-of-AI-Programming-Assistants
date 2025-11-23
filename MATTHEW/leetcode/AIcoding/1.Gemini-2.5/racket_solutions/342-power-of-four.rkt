(define (is-power-of-four n)
  (and (> n 0)
       (= (bitwise-and n (- n 1)) 0)
       (= (bitwise-and n #xAAAAAAAA) 0)))