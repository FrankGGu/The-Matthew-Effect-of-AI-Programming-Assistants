(define (is-robot-bounded instructions)
  (let loop ([x 0] [y 0] [dx 0] [dy 1] [steps instructions])
    (if (null? steps)
        (or (and (= x 0) (= y 0)) (not (and (= dx 0) (= dy 1))))
        (case (car steps)
          [(#\G) (loop (+ x dx) (+ y dy) dx dy (cdr steps))]
          [(#\L) (loop x y (- dy) dx (cdr steps))]
          [(#\R) (loop x y dy (- dx) (cdr steps))]))))