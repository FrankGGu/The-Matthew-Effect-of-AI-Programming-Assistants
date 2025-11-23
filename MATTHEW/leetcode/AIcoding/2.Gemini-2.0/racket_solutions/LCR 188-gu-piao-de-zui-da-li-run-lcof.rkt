(define (max-profit prices)
  (define (helper prices min-price max-profit)
    (cond
      [(empty? prices) max-profit]
      [(< (first prices) min-price) (helper (rest prices) (first prices) max-profit)]
      [else (helper (rest prices) min-price (max max-profit (- (first prices) min-price)))]))
  (if (empty? prices)
      0
      (helper (rest prices) (first prices) 0)))