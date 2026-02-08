(define (maxProfit prices)
  (let loop ((i 0) (first-buy #f) (second-buy #f) (first-sell 0) (second-sell 0))
    (if (>= i (length prices))
        second-sell
        (let* ((price (list-ref prices i))
               (first-buy (if (or (not first-buy) (< price first-buy)) price first-buy))
               (first-sell (if (and first-sell (> price first-sell)) price first-sell))
               (second-buy (if (and first-sell (or (not second-buy) (< price second-buy))) price second-buy))
               (second-sell (if (and second-buy (> price second-sell)) price second-sell)))
          (loop (+ i 1) first-buy second-buy first-sell second-sell))))))

(maxProfit '(3 2 6 5 0 3))