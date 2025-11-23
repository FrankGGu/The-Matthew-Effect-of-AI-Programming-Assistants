(define (carFleet target position speed)
  (define cars (map list position speed))
  (define sorted-cars (sort cars (lambda (a b) (> (car a) (car b)))))
  (define fleets 0)
  (define last-time 0)

  (for ([car sorted-cars])
    (define pos (car car))
    (define spd (cadr car))
    (define time (/ (- target pos) spd))
    (when (> time last-time)
      (set! fleets (+ fleets 1))
      (set! last-time time)))

  fleets)

(carFleet 12 '(10 8 0 5 3) '(2 4 1 1 3))