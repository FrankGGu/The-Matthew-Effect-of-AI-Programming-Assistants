(define (angle-clock hour minutes)
  (let* ([hour-angle (modulo (+ (* hour 30) (/ minutes 2)) 360)]
         [minute-angle (modulo (* minutes 6) 360)]
         [diff (abs (- hour-angle minute-angle))]
         [ans (min diff (- 360 diff))])
    ans))