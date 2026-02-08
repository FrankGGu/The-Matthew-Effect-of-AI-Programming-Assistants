(define (max-sales sales)
  (define n (length sales))
  (if (= n 0)
      0
      (let loop ([i 1] [current-max (first sales)] [global-max (first sales)])
        (if (= i n)
            global-max
            (let ([new-current (max (list-ref sales i) (+ current-max (list-ref sales i)))])
              (loop (add1 i) new-current (max global-max new-current)))))))