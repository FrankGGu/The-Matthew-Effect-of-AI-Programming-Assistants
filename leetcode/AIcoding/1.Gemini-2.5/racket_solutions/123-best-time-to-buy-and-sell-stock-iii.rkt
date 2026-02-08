(define (max-profit prices)
  (define initial-buy -100001)

  (define-values (buy1 sell1 buy2 sell2)
    (for/fold ([b1 initial-buy]
               [s1 0]
               [b2 initial-buy]
               [s2 0])
              ([price (in-list prices)])
      (let* ([next-b1 (max b1 (- price))]
             [next-s1 (max s1 (+ price next-b1))]
             [next-b2 (max b2 (- next-s1 price))]
             [next-s2 (max s2 (+ price next-b2))])
        (values next-b1 next-s1 next-b2 next-s2))))
  s2)