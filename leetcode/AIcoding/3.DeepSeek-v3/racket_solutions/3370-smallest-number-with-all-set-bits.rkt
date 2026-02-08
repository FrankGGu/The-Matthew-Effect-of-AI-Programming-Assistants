(define/contract (smallest-number k)
  (-> exact-integer? exact-integer?)
  (bitwise-arithmetic-shift-left 1 (sub1 k)))