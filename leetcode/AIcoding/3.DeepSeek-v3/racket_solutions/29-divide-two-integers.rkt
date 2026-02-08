(define (divide dividend divisor)
  (if (or (= dividend -2147483648) (= divisor -2147483648))
      (let ([sign (if (xor (< dividend 0) (< divisor 0)) -1 1)]
            [dividend (abs dividend)]
            [divisor (abs divisor)])
        (let loop ([dvd dividend] [dvs divisor] [res 0])
          (if (< dvd dvs)
              (min 2147483647 (* sign res))
              (let ([temp dvs] [multiple 1])
                (let inner-loop ([temp temp] [multiple multiple])
                  (if (<= (+ temp temp) dvd)
                      (inner-loop (+ temp temp) (+ multiple multiple))
                      (loop (- dvd temp) dvs (+ res multiple)))))))
      (let ([sign (if (xor (< dividend 0) (< divisor 0)) -1 1)]
            [dividend (abs dividend)]
            [divisor (abs divisor)])
        (let loop ([dvd dividend] [dvs divisor] [res 0])
          (if (< dvd dvs)
              (* sign res)
              (let ([temp dvs] [multiple 1])
                (let inner-loop ([temp temp] [multiple multiple])
                  (if (<= (+ temp temp) dvd)
                      (inner-loop (+ temp temp) (+ multiple multiple))
                      (loop (- dvd temp) dvs (+ res multiple))))))))))