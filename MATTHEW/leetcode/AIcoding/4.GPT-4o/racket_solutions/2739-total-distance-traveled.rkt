(define (distanceTraveled(mainTank, additionalTanks))
  (define max-distance (* mainTank 5))
  (define extra-distance (min (* 20 additionalTanks) (- max-distance 5)))
  (+ max-distance extra-distance))