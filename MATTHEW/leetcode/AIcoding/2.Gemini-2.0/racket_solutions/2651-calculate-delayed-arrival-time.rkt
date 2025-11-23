(define (calculate-delayed-arrival-time arrival-time delayed-time)
  (modulo (+ arrival-time delayed-time) 24))