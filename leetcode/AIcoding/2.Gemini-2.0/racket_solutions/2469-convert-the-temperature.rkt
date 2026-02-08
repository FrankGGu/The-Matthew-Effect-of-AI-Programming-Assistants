(define (convert-temperature celsius)
  (list (+ celsius 273.15) (+ (* celsius 1.8) 32)))