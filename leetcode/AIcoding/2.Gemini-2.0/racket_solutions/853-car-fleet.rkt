(define (car-fleet target position speed)
  (define cars (length position))
  (define cars-with-time
    (map (lambda (p s)
           (cons p (/ (target - p) s)))
         position
         speed))

  (define sorted-cars
    (sort cars-with-time > #:key car))

  (define (count-fleets sorted-cars current-max-time count)
    (cond
      [(empty? sorted-cars) count]
      [(>= (cdr (car sorted-cars)) current-max-time)
       (count-fleets (cdr sorted-cars) (cdr (car sorted-cars)) (+ count 1))]
      [else (count-fleets (cdr sorted-cars) current-max-time count)]))

  (if (empty? sorted-cars)
      0
      (count-fleets (cdr sorted-cars) (cdr (car sorted-cars)) 1)))