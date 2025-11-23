(define (traffic-light-choices n)
  (cond [(= n 0) 1]
        [(= n 1) 2]
        [else (+ (* 2 (traffic-light-choices (- n 1))) (traffic-light-choices (- n 2)))]))