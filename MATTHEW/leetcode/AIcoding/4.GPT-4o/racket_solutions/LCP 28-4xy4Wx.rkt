(define (ways-to-buy-pens-and-pencils total-pens total-pencils cost-per-pen cost-per-pencil)
  (define (count-ways remaining-pens)
    (if (< remaining-pens 0)
        0
        (+ 1 (for/sum ([j (in-range 0 (add1 (quotient total-pencils cost-per-pencil)))])
               (count-ways (- remaining-pens cost-per-pen))))))
  (count-ways total-pens))