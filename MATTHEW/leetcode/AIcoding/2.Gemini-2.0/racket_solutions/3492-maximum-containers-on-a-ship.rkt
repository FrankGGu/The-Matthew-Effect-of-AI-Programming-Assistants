(define (maximum-units box-types truck-size)
  (let* ([sorted-box-types (sort box-types > #:key second)]
         [max-units (let loop ([boxes sorted-box-types] [remaining-truck-size truck-size] [current-units 0])
                      (cond
                        [(or (null? boxes) (<= remaining-truck-size 0)) current-units]
                        [else
                         (let ([num-boxes (first (first boxes))]
                               [units-per-box (second (first boxes))])
                           (if (>= remaining-truck-size num-boxes)
                               (loop (rest boxes) (- remaining-truck-size num-boxes) (+ current-units (* num-boxes units-per-box)))
                               (loop (rest boxes) 0 (+ current-units (* remaining-truck-size units-per-box))))))]))])
    max-units))