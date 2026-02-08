(define (longest-new-string x y z)
  (cond
    [(= x y) (+ (* x 2) (* 2 z))]
    [(> x y) (+ (* y 2) (* 2 z) 1)]
    [else (+ (* x 2) (* 2 z) 1)]))