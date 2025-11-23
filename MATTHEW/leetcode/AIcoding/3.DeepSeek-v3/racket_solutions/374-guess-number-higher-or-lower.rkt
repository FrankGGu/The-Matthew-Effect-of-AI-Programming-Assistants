(define (guess-number n)
  (let loop ([low 1] [high n])
    (let* ([mid (quotient (+ low high) 2)]
           [res (guess mid)])
      (cond
        [(= res 0) mid]
        [(= res 1) (loop (+ mid 1) high)]
        [else (loop low (- mid 1))]))))