(define (plan-brush n m)
  (define (dp i j)
    (cond
      [(= i 0) 0]
      [(= j 0) 1]
      [else (+ (dp (- i 1) j) (dp i (- j 1)))]))
  (dp n m))

(plan-brush 3 5)