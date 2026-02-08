(define/contract (convert-temperature celsius)
  (-> number? (list/c number? number?))
  (list (+ celsius 273.15) (+ (* celsius 1.8) 32.0)))