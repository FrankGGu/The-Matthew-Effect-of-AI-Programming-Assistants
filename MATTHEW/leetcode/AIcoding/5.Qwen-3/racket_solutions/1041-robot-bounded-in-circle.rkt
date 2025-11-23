(define (is-robot-bounded-in-circle instructions)
  (let* ([directions '((0 1) (1 0) (0 -1) (-1 0))]
         [x 0]
         [y 0]
         [dir 0])
    (for ([c instructions])
      (cond [(char=? c #\L) (set! dir (modulo (- dir 1) 4))]
            [(char=? c #\R) (set! dir (modulo (+ dir 1) 4))]
            [else
             (let ([dx (car (list-ref directions dir))]
                   [dy (cadr (list-ref directions dir))])
               (set! x (+ x dx))
               (set! y (+ y dy)))]))
    (or (and (= x 0) (= y 0)) (not (= dir 0)))))