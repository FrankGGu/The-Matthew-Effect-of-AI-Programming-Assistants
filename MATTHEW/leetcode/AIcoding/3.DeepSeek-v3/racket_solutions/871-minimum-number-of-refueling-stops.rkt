(define/contract (min-refuel-stops target start-fuel stations)
  (-> exact-integer? exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (let loop ([current-fuel start-fuel]
             [position 0]
             [stops 0]
             [passed-stations '()]
             [remaining-stations stations])
    (if (>= (+ position current-fuel) target)
        stops
        (let ([reachable-stations (filter (lambda (s) (<= (car s) (+ position current-fuel))) remaining-stations)])
          (if (null? reachable-stations)
              -1
              (let* ([max-fuel-station (argmax cadr reachable-stations)]
                     [new-fuel (- (+ current-fuel (car max-fuel-station) (- position)) (car max-fuel-station))]
                     [new-position (car max-fuel-station)]
                     [new-stops (add1 stops)]
                     [new-passed (cons max-fuel-station passed-stations)]
                     [new-remaining (remove max-fuel-station remaining-stations)])
                (loop new-fuel new-position new-stops new-passed new-remaining)))))))