(define (maximumProfit stocks discounts k)
  (define n (length stocks))
  (define (helper i remaining-discounts)
    (cond
      [(>= i n) 0]
      [else
       (let ([profit1 (+ (list-ref stocks i) (helper (+ i 1) remaining-discounts))]
             [profit2 (if (> remaining-discounts 0)
                          (+ (floor (/ (list-ref stocks i) 2)) (helper (+ i 1) (- remaining-discounts 1)))
                          -inf.0)])
         (max profit1 profit2))]))
  (helper 0 k))