(define (findDelayedArrivalTime(arrivalTime delay)
  (modulo (+ arrivalTime delay) 24))