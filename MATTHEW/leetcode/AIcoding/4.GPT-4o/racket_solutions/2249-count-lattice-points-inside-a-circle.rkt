(define (countLatticePoints circles)
  (define (point-in-circle x y radius)
    (<= (+ (* x x) (* y y)) (* radius radius)))
  (define (count-points x0 y0 radius)
    (let loop ((x (- radius)) (count 0))
      (if (< x 0)
          count
          (let loop-y ((y (- (sqrt (- (* radius radius) (* x x)))) 0) (count count))
            (if (> y (sqrt (- (* radius radius) (* x x))))
                count
                (loop-y (+ y 1) (+ count 1))))))
  (apply + (map (lambda (circle)
                  (count-points (car circle) (cadr circle) (caddr circle)))
                circles)))