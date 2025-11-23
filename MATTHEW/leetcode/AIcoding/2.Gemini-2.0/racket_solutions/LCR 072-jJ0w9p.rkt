(define (my-sqrt x)
  (define (helper low high)
    (if (> low high)
        high
        (let ((mid (floor (+ low high) 2)))
          (cond
            ((> (* mid mid) x) (helper low (- mid 1)))
            ((< (* mid mid) x) (helper (+ mid 1) high))
            (else mid)))))
  (helper 0 x))