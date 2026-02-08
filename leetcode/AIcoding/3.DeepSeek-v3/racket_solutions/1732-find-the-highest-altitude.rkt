(define/contract (largest-altitude gain)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([altitude 0] [max-altitude 0] [rest gain])
    (if (null? rest)
        max-altitude
        (let* ([new-altitude (+ altitude (car rest))]
               [new-max (max max-altitude new-altitude)])
          (loop new-altitude new-max (cdr rest))))))