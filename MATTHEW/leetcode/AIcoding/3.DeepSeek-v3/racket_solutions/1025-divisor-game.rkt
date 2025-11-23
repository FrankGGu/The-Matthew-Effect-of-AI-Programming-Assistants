(define/contract (divisor-game n)
  (-> exact-integer? boolean?)
  (= (modulo n 2) 0))