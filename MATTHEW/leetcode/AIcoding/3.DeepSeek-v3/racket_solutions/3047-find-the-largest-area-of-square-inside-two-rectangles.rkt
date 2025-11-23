(define (largest-square_area ax1 ay1 ax2 ay2 bx1 by1 bx2 by2)
  (define (overlap x1 x2 y1 y2)
    (let ([start (max x1 y1)]
          [end (min x2 y2)])
      (if (< start end) (- end start) 0)))

  (let ([x_overlap (overlap ax1 ax2 bx1 bx2)]
        [y_overlap (overlap ay1 ay2 by1 by2)])
    (let ([side (min x_overlap y_overlap)])
      (* side side))))