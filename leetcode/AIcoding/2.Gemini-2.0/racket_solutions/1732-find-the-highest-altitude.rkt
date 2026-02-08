(define (largestAltitude gain)
  (let loop ([gains gain] [current-altitude 0] [max-altitude 0])
    (cond
      [(null? gains) max-altitude]
      [else (let ([new-altitude (+ current-altitude (car gains))])
              (loop (cdr gains) new-altitude (max max-altitude new-altitude)))])))