(define (num-water-bottles num-bottles num-exchange)
  (let loop ([bottles num-bottles]
             [total 0])
    (if (zero? bottles)
        total
        (let* ([drunk bottles]
               [empty bottles]
               [new (quotient empty num-exchange)])
          (loop new (+ total drunk))))))