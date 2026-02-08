(define (is-reachable-at-time sx sy fx fy t)
  (let* ([dx (abs (- sx fx))]
         [dy (abs (- sy fy))]
         [max-diff (max dx dy)])
    (cond
      [(and (= dx 0) (= dy 0) (= t 1)) #f]
      [(<= max-diff t) #t]
      [else #f])))