(define (count-k-reducible-numbers-less-than-n n k)
  (if (<= k 0)
      0
      (floor (/ (- n 1) k))))