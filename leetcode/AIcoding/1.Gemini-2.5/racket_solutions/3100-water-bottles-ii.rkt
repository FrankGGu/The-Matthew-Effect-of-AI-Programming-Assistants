(define (water-bottles numBottles numExchange)
  (let loop ((current-full numBottles)
             (current-empty 0)
             (total-drunk 0))
    (if (= current-full 0)
        total-drunk
        (let* ((drunk-this-round current-full)
               (new-total-drunk (+ total-drunk drunk-this-round))
               (new-empty-bottles (+ current-empty drunk-this-round))
               (exchanged-bottles (quotient new-empty-bottles numExchange))
               (remaining-empty-bottles (remainder new-empty-bottles numExchange)))
          (loop exchanged-bottles
                remaining-empty-bottles
                new-total-drunk)))))