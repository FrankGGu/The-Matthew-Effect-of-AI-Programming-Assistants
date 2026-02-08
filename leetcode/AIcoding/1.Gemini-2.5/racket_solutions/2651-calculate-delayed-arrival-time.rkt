(define (calculate-delayed-arrival-time arrivalTime delayedTime)
  (modulo (+ arrivalTime delayedTime) 24))