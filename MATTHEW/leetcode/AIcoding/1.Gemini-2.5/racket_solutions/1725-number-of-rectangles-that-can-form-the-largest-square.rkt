(define (count-good-rectangles rectangles)
  (let* ((max-square-side
          (apply max
                 (map (lambda (rect)
                        (min (car rect) (cadr rect)))
                      rectangles)))
         (count
          (length
           (filter (lambda (rect)
                     (= (min (car rect) (cadr rect)) max-square-side))
                   rectangles))))
    count))