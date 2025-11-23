(define (is-boomerang points)
  (let* ([p1 (car points)]
         [p2 (cadr points)]
         [p3 (caddr points)]
         [x1 (car p1)]
         [y1 (cadr p1)]
         [x2 (car p2)]
         [y2 (cadr p2)]
         [x3 (car p3)]
         [y3 (cadr p3)])
    (not (= (- (* (- x2 x1) (- y3 y1)) (* (- y2 y1) (- x3 x1))) 0))))