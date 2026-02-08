(define (smallest-even-multiple n)
  (if (= 0 (modulo n 2))
      n
      (* n 2)))