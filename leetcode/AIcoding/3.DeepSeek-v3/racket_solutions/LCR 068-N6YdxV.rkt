(define/contract (search-insert nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([low 0] [high (sub1 (length nums))])
    (if (> low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (cond
            [(= (list-ref nums mid) target) mid]
            [(< (list-ref nums mid) target) (loop (add1 mid) high)]
            [else (loop low (sub1 mid))])))))