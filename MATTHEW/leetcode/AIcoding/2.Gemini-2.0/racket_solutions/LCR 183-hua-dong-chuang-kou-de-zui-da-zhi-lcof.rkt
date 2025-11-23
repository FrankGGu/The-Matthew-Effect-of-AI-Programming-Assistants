(define (highest-altitude gain)
  (let loop ([altitude 0] [max-altitude 0] [rest gain])
    (if (null? rest)
        max-altitude
        (let ([new-altitude (+ altitude (car rest))])
          (loop new-altitude (max max-altitude new-altitude) (cdr rest))))))