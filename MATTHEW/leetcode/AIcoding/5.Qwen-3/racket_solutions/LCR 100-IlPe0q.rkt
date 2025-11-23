(define (minimum-total-triangle triangle)
  (define (helper row index)
    (if (>= row (length triangle))
        0
        (let ((current (list-ref (list-ref triangle row) index)))
          (+ current (min (helper (+ row 1) index) (helper (+ row 1) (+ index 1)))))))
  (helper 0 0))