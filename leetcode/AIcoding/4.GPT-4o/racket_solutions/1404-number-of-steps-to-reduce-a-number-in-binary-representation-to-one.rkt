(define (number-of-steps (num : Integer))
  (define (helper n count)
    (cond
      [(= n 0) count]
      [(even? n) (helper (quotient n 2) (+ count 1))]
      [else (helper (- n 1) (+ count 1))]))
  (helper num 0))