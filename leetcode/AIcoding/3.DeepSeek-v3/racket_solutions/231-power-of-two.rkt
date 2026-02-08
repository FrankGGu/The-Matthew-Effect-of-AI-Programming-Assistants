(define/contract (is-power-of-two n)
  (-> exact-integer? boolean?)
  (and (> n 0) (zero? (bitwise-and n (- n 1)))))