(define/contract (angle-clock hour minutes)
  (-> exact-integer? exact-integer? flonum?)
  (let* ([hour-angle (+ (* (modulo hour 12) 30) (* minutes 0.5))]
         [minute-angle (* minutes 6)]
         [angle (abs (- hour-angle minute-angle))])
    (min angle (- 360 angle))))