(define/contract (my-sqrt x)
  (-> exact-integer? exact-integer?)
  (let loop ([low 0] [high x])
    (if (> low high)
        high
        (let* ([mid (quotient (+ low high) 2)]
               [square (* mid mid)])
          (cond
            [(= square x) mid]
            [(< square x) (loop (add1 mid) high)]
            [else (loop low (sub1 mid))])))))