#lang racket

(define underground-system%
  (class object%
    (init-field
     [check-ins (make-hash)] ; Maps id -> (list start-station start-time)
     [trip-data (make-hash)]) ; Maps (list start-station end-station) -> (list total-time num-trips)

    (define/public (checkIn id stationName t)
      (hash-set! check-ins id (list stationName t)))

    (define/public (checkOut id stationName t)
      (define check-in-info (hash-ref check-ins id))
      (define start-station (car check-in-info))
      (define start-time (cadr check-in-info))

      (define trip-duration (- t start-time))
      (define station-pair (list start-station stationName))

      (if (hash-has-key? trip-data station-pair)
          (let ([current-data (hash-ref trip-data station-pair)])
            (define current-total-time (car current-data))
            (define current-num-trips (cadr current-data))
            (hash-set! trip-data station-pair
                       (list (+ current-total-time trip-duration)
                             (add1 current-num-trips))))
          (hash-set! trip-data station-pair
                     (list trip-duration 1)))

      (hash-remove! check-ins id))

    (define/public (getAverageTime startStation endStation)
      (define station-pair (list startStation endStation))
      (define data (hash-ref trip-data station-pair))
      (define total-time (car data))
      (define num-trips (cadr data))
      (/ total-time num-trips))))