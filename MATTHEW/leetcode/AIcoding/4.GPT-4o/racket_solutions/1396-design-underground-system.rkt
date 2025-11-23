(define UndergroundSystem
  (lambda ()
    (define check-ins (hash))
    (define journeys (hash))

    (define (checkIn id stationName t)
      (hash-set! check-ins id (list stationName t)))

    (define (checkOut id stationName t)
      (define check-in (hash-ref check-ins id))
      (define start-station (car check-in))
      (define start-time (cadr check-in))
      (hash-set! journeys (list start-station stationName)
                  (if (hash-has-key? journeys (list start-station stationName))
                      (+ (hash-ref journeys (list start-station stationName)) (- t start-time))
                      (- t start-time)))
      (hash-remove! check-ins id))

    (define (getAverageTime startStation endStation)
      (define total-time (hash-ref journeys (list startStation endStation)))
      (define total-rides (if (hash-has-key? journeys (list startStation endStation)) 1 0))
      (/ total-time total-rides))

    (define (api)
      (lambda (cmd)
        (cond
          ((equal? (car cmd) 'checkIn) (checkIn (cadr cmd) (caddr cmd) (cadddr cmd)))
          ((equal? (car cmd) 'checkOut) (checkOut (cadr cmd) (caddr cmd) (cadddr cmd)))
          ((equal? (car cmd) 'getAverageTime) (getAverageTime (cadr cmd) (caddr cmd))))))

    (api)))