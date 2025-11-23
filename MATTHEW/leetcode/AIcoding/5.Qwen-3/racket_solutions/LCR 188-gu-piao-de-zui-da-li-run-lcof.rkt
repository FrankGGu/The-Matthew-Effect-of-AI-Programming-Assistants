(define (max-profit prices)
  (let loop ([prices prices] [min-price +inf.0] [max-profit 0])
    (if (null? prices)
        max-profit
        (let* ([price (car prices)]
               [min-price (min min-price price)]
               [profit (- price min-price)])
          (loop (cdr prices) min-price (max max-profit profit))))))