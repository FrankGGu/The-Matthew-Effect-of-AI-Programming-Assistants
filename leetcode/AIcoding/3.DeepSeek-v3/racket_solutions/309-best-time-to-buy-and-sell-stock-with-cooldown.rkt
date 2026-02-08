(define/contract (max-profit prices)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? prices)
      0
      (let loop ([i 1] [hold (- (first prices))] [no-hold 0] [cooldown 0])
        (if (>= i (length prices))
            (max no-hold cooldown)
            (let* ([price (list-ref prices i)]
                   [new-hold (max hold (- price no-hold))]
                   [new-no-hold (max no-hold cooldown)]
                   [new-cooldown (+ hold price)])
              (loop (add1 i) new-hold new-no-hold new-cooldown))))))