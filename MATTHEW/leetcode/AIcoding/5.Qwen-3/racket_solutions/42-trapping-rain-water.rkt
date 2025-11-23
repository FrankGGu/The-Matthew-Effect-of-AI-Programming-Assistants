(define (trap height)
  (define (helper left right left-max right-max area)
    (if (>= left right) area
        (if (<= left-max right-max)
            (helper (+ left 1) right (max left-max (list-ref height left)) right-max (+ area (- left-max (list-ref height left))))
            (helper left (- right 1) left-max (max right-max (list-ref height right)) (+ area (- right-max (list-ref height right)))))))
  (helper 0 (- (length height) 1) 0 0 0))