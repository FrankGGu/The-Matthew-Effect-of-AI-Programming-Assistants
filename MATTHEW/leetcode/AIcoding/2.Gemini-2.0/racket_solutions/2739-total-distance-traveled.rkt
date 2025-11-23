(define (total-distance-traveled mainTank additionalTank)
  (let loop ([distance 0] [main mainTank] [additional additionalTank])
    (cond
      [(zero? main) distance]
      [(<= main 5) (+ distance (* main 10))]
      [else (let ([use (min main 5)])
              (cond
                [(zero? additional) (+ distance (* main 10))]
                [(<= additional (quotient main 5))
                 (loop (+ distance (* use 10)) (- main use) (- additional (quotient main 5)))]
                [else (loop (+ distance (* use 10)) (- main use) (- additional (quotient main 5))))]
              (loop (+ distance (* 5 10)) (- main 5) (- additional 1)))))))