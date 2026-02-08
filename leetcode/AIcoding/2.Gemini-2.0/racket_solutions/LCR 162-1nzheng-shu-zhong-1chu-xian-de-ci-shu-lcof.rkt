(define (countDigitOne n)
  (let loop ([n n] [digit 1] [res 0] [high 0] [cur 0] [low 0])
    (cond
      [(zero? n) res]
      [else
       (let* ([cur (modulo n 10)]
              [high (quotient n 10)]
              [res (+ res (* high digit)
                      (cond
                        [(zero? cur) 0]
                        [(= cur 1) (add1 low)]
                        [else digit]))])
         (loop high (* digit 10) res high cur (+ (* cur digit) low)))])))