(define (max-area rectangles points)
  (let* ([valid-rects
          (filter
           (lambda (rect)
             (for/and ([point points])
               (and (<= (first rect) (first point) (third rect))
                    (<= (second rect) (second point) (fourth rect)))))
           rectangles)]
         [areas
          (map
           (lambda (rect)
             (* (- (third rect) (first rect))
                (- (fourth rect) (second rect))))
           valid-rects)])
    (if (null? areas)
        0
        (apply max areas))))