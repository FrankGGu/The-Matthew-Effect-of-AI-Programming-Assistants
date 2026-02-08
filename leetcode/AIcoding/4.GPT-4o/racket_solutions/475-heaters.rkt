(define (findRadius houses heaters)
  (define (distance house heater)
    (abs (- house heater)))
  (define (min-distance house)
    (apply min (map (lambda (h) (distance house h)) heaters)))
  (apply max (map min-distance houses)))

(define (findRadius houses heaters)
  (min-distance houses))