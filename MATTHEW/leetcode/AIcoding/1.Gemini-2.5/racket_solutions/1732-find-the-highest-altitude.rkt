(define (largest-altitude gain)
  (for/fold ([current-alt 0]
             [max-alt 0])
            ([g (in-list gain)])
    (let ([new-current-alt (+ current-alt g)])
      (values new-current-alt (max max-alt new-current-alt)))))