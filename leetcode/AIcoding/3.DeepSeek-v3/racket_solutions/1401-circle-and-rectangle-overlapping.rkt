(define (check-overlap radius xCenter yCenter x1 y1 x2 y2)
  (let* ((closestX (max x1 (min xCenter x2)))
         (closestY (max y1 (min yCenter y2)))
    (<= (+ (expt (- closestX xCenter) 2) (expt (- closestY yCenter) 2)) ) (expt radius 2)))))