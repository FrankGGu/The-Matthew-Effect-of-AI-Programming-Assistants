(define (maxProfit prices)
  (define (helper prices min-price max-profit)
    (if (null? prices)
        max-profit
        (let ((current-price (car prices)))
          (let ((new-min (min min-price current-price))
                (new-profit (max max-profit (- current-price new-min))))
            (helper (cdr prices) new-min new-profit)))))
  (helper prices (car prices) 0))