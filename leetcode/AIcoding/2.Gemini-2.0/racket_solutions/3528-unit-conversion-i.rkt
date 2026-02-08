(define (convert-length value unit)
  (match unit
    ["km" (* value 1000.0)]
    ["m" value]
    ["cm" (/ value 100.0)]
    ["mm" (/ value 1000.0)]
    ["mile" (* value 1609.34)]
    ["yard" (* value 0.9144)]
    ["foot" (* value 0.3048)]
    ["inch" (* value 0.0254)]
    [else value]))