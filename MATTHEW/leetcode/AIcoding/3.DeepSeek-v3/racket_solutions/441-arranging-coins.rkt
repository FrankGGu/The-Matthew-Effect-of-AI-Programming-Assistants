(define/contract (arrange-coins n)
  (-> exact-integer? exact-integer?)
  (let loop ([low 1] [high n] [res 0])
    (if (> low high)
        res
        (let* ([mid (quotient (+ low high) 2)]
               [coins (quotient (* mid (+ mid 1)) 2)])
          (cond
            [(= coins n) mid]
            [(< coins n) (loop (+ mid 1) high mid)]
            [else (loop low (- mid 1) res)])))))