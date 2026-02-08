(define/contract (max-profit prices)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([prices prices] [min-price +inf.0] [max-profit 0])
    (if (null? prices)
        max-profit
        (let ([price (car prices)])
          (loop (cdr prices)
                (min min-price price)
                (max max-profit (- price min-price)))))))