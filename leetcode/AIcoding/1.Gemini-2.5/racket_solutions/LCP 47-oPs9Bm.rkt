#lang racket

(define (入场安检 n times)
  (define (check time-limit)
    (for/sum ([t times])
      (floor (/ time-limit t))))

  (define min-time 1)
  (define max-time (* n (apply max times)))

  (let loop ((low min-time) (high max-time) (current-ans max-time))
    (if (> low high)
        current-ans
        (let* ((mid (+ low (floor (/ (- high low) 2))))
               (processed-people (check mid)))
          (if (>= processed-people n)
              (loop low (- mid 1) mid)
              (loop (+ mid 1) high current-ans))))))