(define (brokenCalculator start target)
  (define (helper start target steps)
    (cond
      [(>= start target) (+ steps (- start target))]
      [(even? target) (helper start (/ target 2) (+ steps 1))]
      [else (helper start (+ target 1) (+ steps 1))]))
  (helper start target 0))