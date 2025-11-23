(define/contract (distance-traveled main-tank additional-tank)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ([main main-tank] [additional additional-tank] [distance 0])
    (cond
      [(<= main 0) distance]
      [else
       (let* ([used (min main 5)]
              [new-main (- main used)]
              [new-distance (+ distance (* used 10))])
         (if (and (>= additional 1) (>= used 5))
             (loop (+ new-main 1) (- additional 1) new-distance)
             (loop new-main additional new-distance)))])))