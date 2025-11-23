(define (convert-temperature celsius)
  (list (+ celsius 273.15) (* celsius 1.80) (+ (* celsius 1.80) 32.00)))