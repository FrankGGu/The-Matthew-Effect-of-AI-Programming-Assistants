(define/contract (colored-cells n)
  (-> exact-integer? exact-integer?)
  (if (= n 1)
      1
      (+ (* (- n 1) (- n 1)) (* (- n 1) n))))