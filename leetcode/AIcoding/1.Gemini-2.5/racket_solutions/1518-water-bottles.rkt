(define (num-water-bottles numBottles numExchange)
  (let loop ((total-drunk numBottles)
             (empty-bottles numBottles))
    (if (< empty-bottles numExchange)
        total-drunk
        (let* ((new-full-bottles (quotient empty-bottles numExchange))
               (remaining-empty-after-exchange (remainder empty-bottles numExchange)))
          (loop (+ total-drunk new-full-bottles)
                (+ remaining-empty-after-exchange new-full-bottles))))))