(define (car-fleet target position speed)
  (let* ([num-cars (length position)]
         [cars (map (lambda (p s) (cons p s)) position speed)]
         [sorted-cars (sort cars (lambda (a b) (> (car a) (car b))))])

    (if (zero? num-cars)
        0
        (let loop ([remaining-cars sorted-cars]
                   [fleets 0]
                   [current-max-time -1.0])
          (if (empty? remaining-cars)
              fleets
              (let* ([car (car remaining-cars)]
                     [p (car car)]
                     [s (cdr car)]
                     [time (/ (exact->inexact (- target p)) (exact->inexact s))])
                (if (> time current-max-time)
                    (loop (cdr remaining-cars) (+ fleets 1) time)
                    (loop (cdr remaining-cars) fleets current-max-time))))))))