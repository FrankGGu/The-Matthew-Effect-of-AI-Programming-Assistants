(define (findTheDistanceValue arr1 arr2 d)
  (define (is-distance-valid x)
    (not (ormap (lambda (y) (<= (abs (- x y)) d)) arr2)))
  (length (filter is-distance-valid arr1)))