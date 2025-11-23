(define (countColoredCells n)
  (if (= n 1)
      1
      (* 4 (- n 1))))