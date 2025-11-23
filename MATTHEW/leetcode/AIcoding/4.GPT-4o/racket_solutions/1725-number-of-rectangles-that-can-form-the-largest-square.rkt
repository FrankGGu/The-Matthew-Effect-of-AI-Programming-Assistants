(define (countGoodRectangles rectangles)
  (define max-side (apply max (map (lambda (rect) (min (car rect) (cadr rect))) rectangles)))
  (define (count-max-side rects side)
    (length (filter (lambda (rect) (and (>= (car rect) side) (>= (cadr rect) side))) rects)))
  (count-max-side rectangles max-side))

(countGoodRectangles '((5 8) (3 9) (5 12) (16 5)))