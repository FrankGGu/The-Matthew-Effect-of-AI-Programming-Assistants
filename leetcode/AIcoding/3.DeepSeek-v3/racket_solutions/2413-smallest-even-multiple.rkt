(define/contract (smallest-even-multiple n)
  (-> exact-integer? exact-integer?)
  (if (even? n) n (* 2 n)))