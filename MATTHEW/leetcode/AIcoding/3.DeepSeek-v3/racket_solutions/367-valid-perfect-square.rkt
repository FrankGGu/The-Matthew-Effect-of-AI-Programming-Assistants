(define/contract (is-perfect-square num)
  (-> exact-integer? boolean?)
  (let loop ([low 1] [high num])
    (if (> low high)
        #f
        (let* ([mid (quotient (+ low high) 2)]
               [square (* mid mid)])
          (cond
            [(= square num) #t]
            [(< square num) (loop (add1 mid) high)]
            [else (loop low (sub1 mid))])))))