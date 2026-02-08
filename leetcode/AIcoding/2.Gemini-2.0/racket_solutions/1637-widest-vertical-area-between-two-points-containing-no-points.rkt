(define (max-width-between-two-points points)
  (let* ((x-coords (sort (map car points) <))
         (widths (map (lambda (x1 x2) (- x2 x1)) x-coords (cdr x-coords))))
    (apply max widths)))