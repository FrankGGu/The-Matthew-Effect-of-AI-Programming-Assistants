(define (largest-area-of-square rects)
  (let* ([x1 (max (min (list-ref (list-ref rects 0) 0) (list-ref (list-ref rects 1) 0)))]
         [y1 (max (min (list-ref (list-ref rects 0) 1) (list-ref (list-ref rects 1) 1)))]
         [x2 (min (max (list-ref (list-ref rects 0) 2) (list-ref (list-ref rects 1) 2)))]
         [y2 (min (max (list-ref (list-ref rects 0) 3) (list-ref (list-ref rects 1) 3)))]
         [side (max 0 (min (- x2 x1) (- y2 y1)))]
         )
    (* side side)))