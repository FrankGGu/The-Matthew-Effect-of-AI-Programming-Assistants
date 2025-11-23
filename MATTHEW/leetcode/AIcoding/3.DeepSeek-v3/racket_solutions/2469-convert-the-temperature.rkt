(define/contract (convert-temperature celsius)
  (-> flonum? (listof flonum?))
  (list (+ celsius 273.15) (+ (* celsius 1.80) 32.0)))