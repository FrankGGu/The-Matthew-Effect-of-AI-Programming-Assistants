(define (max-profit-from-trading-stocks-with-discounts prices discounts)
  (let* ([n (vector-length prices)])
    (if (<= n 1)
        0
        (for/fold ([max-profit 0]
                   [min-buy-price (vector-ref prices 0)])
                  ([i (in-range 1 n)])
          (let* ([current-price (vector-ref prices i)]
                 [current-discount (vector-ref discounts i)]
                 ; Profit = sell_price - (buy_price - discount_on_sell_day)
                 ;        = sell_price - buy_price + discount_on_sell_day
                 ;        = current_price + current_discount - min_buy_price
                 [potential-profit (+ current-price current-discount (- min-buy-price))])
            (values (max max-profit potential-profit)
                    (min min-buy-price current-price)))))))