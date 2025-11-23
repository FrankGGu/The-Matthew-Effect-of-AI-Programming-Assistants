(define (find-the-distance-value arr1 arr2 d)
  (define (check-element x arr2 d)
    (not (for/or ([y arr2])
           (<= (abs (- x y)) d))))

  (for/sum ([x arr1])
    (if (check-element x arr2 d) 1 0)))