(define (num-water-bottles numBottles numExchange)
  (let loop ([bottles numBottles]
             [empty 0]
             [total numBottles])
    (if (< bottles numExchange)
        total
        (let ([new-bottles (floor (/ bottles numExchange))])
          (loop (+ new-bottles (- bottles (* new-bottles numExchange)))
                0
                (+ total new-bottles))))))