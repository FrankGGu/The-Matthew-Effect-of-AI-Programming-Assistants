(define (arrangement n)
  (if (= n 1)
      1
      (+ (* 2 (arrangement (- n 1))) 1)))