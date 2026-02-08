(define (is-reachable-at-time sx sy fx fy t)
  (let ([dx (abs (- fx sx))]
        [dy (abs (- fy sy))])
    (cond
      [(and (= dx 0) (= dy 0)) (not (= t 1))]
      [else (<= (max dx dy) t)])))