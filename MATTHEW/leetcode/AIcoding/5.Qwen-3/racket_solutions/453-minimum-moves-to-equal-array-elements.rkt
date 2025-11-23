(define (min-moves nums)
  (let ((min-val (apply min nums)))
    (apply + (map (lambda (x) (- x min-val)) nums))))