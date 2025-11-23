(define (tallest-billboard rods)
  (define (dp rods index diff)
    (if (and (zero? diff) (zero? index))
        0
        (if (or (= index (length rods)) (< (abs diff) 0))
            -1
            (let* ((rod (list-ref rods index))
                   (add-rod (dp rods (+ index 1) (+ diff rod)))
                   (use-rod (dp rods (+ index 1) (- diff rod)))
                   (skip-rod (dp rods (+ index 1) diff)))
              (max (if (negative? add-rod) -1 add-rod)
                   (if (negative? use-rod) -1 (+ use-rod rod))
                   skip-rod)))))
  (dp rods 0 0))