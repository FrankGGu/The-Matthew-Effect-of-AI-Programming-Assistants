(define (nearest-point x y points)
  (define (distance p)
    (let ((px (car p))
          (py (cadr p)))
      (if (or (= x px) (= y py))
          (abs (- x px)) ; Use only x distance for comparison
          +inf.0))) ; Return infinity if not matching x or y
  (define nearest (for/fold ([min-dist +inf.0] [nearest-point #f])
                   ([p points])
    (let ((dist (distance p)))
      (if (< dist min-dist)
          (values dist p)
          (values min-dist nearest-point)))))
  (if (or (eq? nearest-point #f) (= (car nearest-point) x) (= (cadr nearest-point) y))
      (list -1 -1)
      nearest-point))

(define (nearest-point-solution points x y)
  (nearest-point x y points))