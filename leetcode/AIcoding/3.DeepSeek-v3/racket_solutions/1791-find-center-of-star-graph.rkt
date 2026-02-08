(define (find-center edges)
  (let ([u (car (car edges))]
        [v (cadr (car edges))]
        [x (car (cadr edges))]
        [y (cadr (cadr edges))])
    (if (or (= u x) (= u y))
        u
        v)))