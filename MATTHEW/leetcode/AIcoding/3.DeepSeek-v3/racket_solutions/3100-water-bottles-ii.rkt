(define (num-water-bottles num-bottles num-exchange)
  (let loop ([bottles num-bottles]
             [total 0]
             [empty 0])
    (if (zero? bottles)
        total
        (let* ([new-total (+ total bottles)]
               [new-empty (+ empty bottles)]
               [new-bottles (quotient new-empty num-exchange)]
               [remaining-empty (remainder new-empty num-exchange)])
          (loop new-bottles new-total remaining-empty))))