(define (arrange-coins n)
  (floor (/ (+ -1 (sqrt (+ 1 (* 8 n)))) 2)))