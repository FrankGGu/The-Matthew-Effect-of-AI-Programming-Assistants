(define (colored-cells n)
  (cond
    [(= n 1) 1]
    [else (+ (* n n) (* (- n 1) (- n 1)))]))