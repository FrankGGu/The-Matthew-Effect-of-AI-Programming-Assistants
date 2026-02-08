(define (convert-units (amount : float) (fromUnit : string) (toUnit : string))
  (define conversion-factors
    (hash "in" 0.0254
          "ft" 0.3048
          "yd" 0.9144
          "mi" 1609.34
          "mm" 0.001
          "cm" 0.01
          "m" 1.0
          "km" 1000.0))
  (let ((base-value (* amount (hash-ref conversion-factors fromUnit))))
    (/ base-value (hash-ref conversion-factors toUnit))))