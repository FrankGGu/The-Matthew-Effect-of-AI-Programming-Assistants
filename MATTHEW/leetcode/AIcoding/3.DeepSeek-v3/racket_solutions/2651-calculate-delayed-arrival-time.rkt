(define/contract (find-delayed-arrival-time arrival-time delayed-time)
  (-> exact-integer? exact-integer? exact-integer?)
  (modulo (+ arrival-time delayed-time) 24))