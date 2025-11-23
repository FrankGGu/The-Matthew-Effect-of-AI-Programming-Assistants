(define (navigation-device commands)
  (let loop ([x 0] [y 0] [direction 0] [commands commands])
    (cond
      [(empty? commands) (list x y)]
      [else
       (let ([command (car commands)]
             [rest-commands (cdr commands)])
         (cond
           [(equal? command "G")
            (cond
              [(= direction 0) (loop (+ x 1) y direction rest-commands)]
              [(= direction 1) (loop x (+ y 1) direction rest-commands)]
              [(= direction 2) (loop (- x 1) y direction rest-commands)]
              [(= direction 3) (loop x (- y 1) direction rest-commands)]
              [else (error "Invalid direction")])]
           [(equal? command "L")
            (loop x y (modulo (- direction 1) 4) rest-commands)]
           [(equal? command "R")
            (loop x y (modulo (+ direction 1) 4) rest-commands)]
           [else (error "Invalid command")]))])))