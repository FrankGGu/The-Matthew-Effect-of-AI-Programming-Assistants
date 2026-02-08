(define (maxWaterBottles numBottles numExchange)
  (define (helper bottles exchanges)
    (if (or (zero? bottles) (zero? exchanges))
        bottles
        (let* ([new-bottles (quotient bottles numExchange)]
               [remaining-bottles (remainder bottles numExchange)]
               [total (if (zero? new-bottles) bottles (+ bottles new-bottles))])
          (helper (+ remaining-bottles new-bottles) exchanges))))
  (helper numBottles numExchange))