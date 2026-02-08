(define/contract (my-sqrt x)
  (-> exact-integer? exact-integer?)
  (if (zero? x)
      0
      (let loop ([low 1] [high x] [res 0])
        (if (> low high)
            res
            (let* ([mid (quotient (+ low high) 2)]
                   [square (* mid mid)])
              (cond
                [(= square x) mid]
                [(< square x) (loop (add1 mid) high mid)]
                [else (loop low (sub1 mid) res)]))))))