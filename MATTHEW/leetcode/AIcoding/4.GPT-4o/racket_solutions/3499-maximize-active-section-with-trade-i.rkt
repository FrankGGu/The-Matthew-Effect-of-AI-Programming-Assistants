(define (maxProfit prices)
  (define (helper prices min-price max-profit)
    (if (null? prices)
        max-profit
        (let* ((current-price (car prices))
               (new-min-price (min min-price current-price))
               (new-profit (- current-price new-min-price)))
          (helper (cdr prices) new-min-price (max max-profit new-profit)))))
  (helper prices (car prices) 0))

(define (maxProfit prices)
  (if (null? prices) 0
      (helper (cdr prices) (car prices) 0)))