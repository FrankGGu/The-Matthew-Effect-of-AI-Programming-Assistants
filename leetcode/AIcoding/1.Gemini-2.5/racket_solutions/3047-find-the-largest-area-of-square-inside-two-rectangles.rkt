(define (largest-square-area rec1 rec2)
  (let* ((x1 (list-ref rec1 0))
         (y1 (list-ref rec1 1))
         (x2 (list-ref rec1 2))
         (y2 (list-ref rec1 3))

         (x3 (list-ref rec2 0))
         (y3 (list-ref rec2 1))
         (x4 (list-ref rec2 2))
         (y4 (list-ref rec2 3))

         (ix1 (max x1 x3))
         (iy1 (max y1 y3))
         (ix2 (min x2 x4))
         (iy2 (min y2 y4)))

    (if (or (>= ix1 ix2) (>= iy1 iy2))
        0
        (let* ((width (- ix2 ix1))
               (height (- iy2 iy1))
               (side (min width height)))
          (* side side)))))