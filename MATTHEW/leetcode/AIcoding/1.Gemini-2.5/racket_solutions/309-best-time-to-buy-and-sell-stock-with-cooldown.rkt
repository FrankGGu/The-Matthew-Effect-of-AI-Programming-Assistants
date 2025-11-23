(define (max-profit prices)
  (define n (length prices))

  (cond
    ((zero? n) 0)
    ((= n 1) 0)
    (else
     (define initial-buy (- (car prices)))
     (define initial-sell -inf.0)
     (define initial-cooldown 0)

     (define-values (final-buy final-sell final-cooldown)
       (for/fold ([buy initial-buy]
                  [sell initial-sell]
                  [cooldown initial-cooldown])
                 ([price (cdr prices)])
         (define prev-buy buy)
         (define prev-sell sell)
         (define prev-cooldown cooldown)

         (define current-buy (max prev-buy (- prev-cooldown price)))
         (define current-sell (+ prev-buy price))
         (define current-cooldown (max prev-sell prev-cooldown))

         (values current-buy current-sell current-cooldown)))

     (max final-sell final-cooldown))))