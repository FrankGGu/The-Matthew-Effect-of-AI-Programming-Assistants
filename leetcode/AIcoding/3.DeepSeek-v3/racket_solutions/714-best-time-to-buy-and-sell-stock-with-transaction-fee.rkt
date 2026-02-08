(define/contract (max-profit prices fee)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([prices prices]
             [cash 0]
             [hold (- (first prices))])
    (if (empty? prices)
        cash
        (let* ([price (first prices)]
               [new-cash (max cash (+ hold price (- fee)))]
               [new-hold (max hold (- cash price))])
          (loop (rest prices) new-cash new-hold)))))