(define (distance x1 y1 x2 y2)
  (sqrt (+ (sqr (- x2 x1)) (sqr (- y2 y1)))))

(define (check-overlap radius x_center y_center x1 y1 x2 y2)
  (let* ([closest_x (cond
                       [(< x_center x1) x1]
                       [(> x_center x2) x2]
                       [else x_center])]
         [closest_y (cond
                       [(< y_center y1) y1]
                       [(> y_center y2) y2]
                       [else y_center])])
    (<= (distance x_center y_center closest_x closest_y) radius)))