(define (is-reachable-at-time sx sy fx fy t)
  (let* ((dx (abs (- fx sx)))
         (dy (abs (- fy sy)))
         (min-time (max dx dy)))
    (cond
      ((= min-time 0)
       (= t 0))
      (else ; min-time > 0
       (and (>= t min-time)
            (= (modulo (- t min-time) 2) 0))))))