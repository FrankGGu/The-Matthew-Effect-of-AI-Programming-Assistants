(define (max-distance points)
  (let* ((n (length points))
         (x-coords (map car points))
         (y-coords (map cdr points))
         (min-x (apply min x-coords))
         (max-x (apply max x-coords))
         (min-y (apply min y-coords))
         (max-y (apply max y-coords))
         (side (max (- max-x min-x) (- max-y min-y))))
    (cond
      [(< n 2) 0]
      [else (inexact->exact (ceiling side))])))