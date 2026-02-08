(define (check-straight-line coordinates)
  (let* ((num-points (length coordinates)))
    (when (< num-points 2)
      (error "Coordinates must have at least 2 points")) ; Should not happen based on constraints

    (let* ((p0 (list-ref coordinates 0))
           (p1 (list-ref coordinates 1))
           (x0 (car p0))
           (y0 (cadr p0))
           (x1 (car p1))
           (y1 (cadr p1))
           (dx (- x1 x0))
           (dy (- y1 y0)))
      (for/all ((i (range 2 num-points)))
        (let* ((pi (list-ref coordinates i))
               (xi (car pi))
               (yi (cadr pi)))
          ;; Check if the cross product (P1-P0) x (Pi-P0) is zero
          ;; This is equivalent to checking if the slopes are equal
          ;; (y1 - y0) / (x1 - x0) == (yi - y0) / (xi - x0)
          ;; To avoid division by zero, we use the cross-product form:
          ;; (y1 - y0) * (xi - x0) == (yi - y0) * (x1 - x0)
          ;; Using pre-calculated dx and dy:
          ;; dy * (xi - x0) == (yi - y0) * dx
          (= (* dy (- xi x0)) (* (- yi y0) dx)))))))