(define (smallest-even-multiple n)
  (if (even? n)
      n
      (* n 2)))