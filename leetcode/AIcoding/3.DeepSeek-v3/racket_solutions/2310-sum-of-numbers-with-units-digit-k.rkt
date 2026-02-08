(define/contract (minimum-numbers num k)
  (-> exact-integer? exact-integer? exact-integer?)
  (if (zero? num)
      0
      (let loop ([i 1] [sum k])
        (cond
          [(> sum num) -1]
          [(= (modulo sum 10) (modulo num 10)) i]
          [else (loop (add1 i) (+ sum k))]))))