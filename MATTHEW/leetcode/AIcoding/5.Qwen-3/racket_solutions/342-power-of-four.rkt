(define (is-power-of-four n)
  (and (> n 0)
       (= (bitwise-and n (sub1 n)) 0)
       (= (bitwise-and n #x55555555) n)))