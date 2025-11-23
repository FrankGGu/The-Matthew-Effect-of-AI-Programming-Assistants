(define (maximum69Number num)
  (define (replace-6-with-9 n)
    (if (zero? n)
        0
        (let ([digit (modulo n 10)]
              [rest (quotient n 10)])
          (if (= digit 6)
              (+ (* 9 (expt 10 (length (number->string rest)))) rest)
              (+ (* digit (expt 10 (length (number->string rest)))) (replace-6-with-9 rest))))))
  (replace-6-with-9 num))