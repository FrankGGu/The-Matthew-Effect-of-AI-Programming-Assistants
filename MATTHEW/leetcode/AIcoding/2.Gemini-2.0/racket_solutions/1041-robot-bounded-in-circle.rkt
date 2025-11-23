(define (is-robot-bounded s)
  (let loop ([x 0] [y 0] [dir 0] [chars (string->list s)])
    (cond
      [(empty? chars)
       (or (and (= x 0) (= y 0)) (not (= dir 0)))]
      [else
       (let ([c (car chars)]
             [rest (cdr chars)])
         (cond
           [(char=? c #\G)
            (cond
              [(= dir 0) (loop (+ x 1) y dir rest)]
              [(= dir 1) (loop x (+ y 1) dir rest)]
              [(= dir 2) (loop (- x 1) y dir rest)]
              [(= dir 3) (loop x (- y 1) dir rest)])]
           [(char=? c #\L)
            (loop x y (modulo (+ dir 1) 4) rest)]
           [(char=? c #\R)
            (loop x y (modulo (+ dir 3) 4) rest)]
           [else #f]))])))