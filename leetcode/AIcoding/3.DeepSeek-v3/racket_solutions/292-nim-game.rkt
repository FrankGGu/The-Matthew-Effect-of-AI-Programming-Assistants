(define/contract (can-win-nim n)
  (-> exact-integer? boolean?)
  (not (zero? (modulo n 4))))