(define/contract (max-profit prices)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? prices)
      0
      (let loop ([min-price (first prices)]
                 [max-profit 0]
                 [rest-prices (rest prices)])
        (if (null? rest-prices)
            max-profit
            (let ([current-price (first rest-prices)])
              (loop (min min-price current-price)
                    (max max-profit (- current-price min-price))
                    (rest rest-prices)))))))