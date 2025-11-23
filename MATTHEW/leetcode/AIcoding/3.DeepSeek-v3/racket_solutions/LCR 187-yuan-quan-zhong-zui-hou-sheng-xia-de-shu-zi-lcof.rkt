(define (last-remaining n)
  (cond
    [(= n 1) 1]
    [else (* 2 (- (+ 1 (floor (/ n 2))) (last-remaining (floor (/ n 2)))))]))