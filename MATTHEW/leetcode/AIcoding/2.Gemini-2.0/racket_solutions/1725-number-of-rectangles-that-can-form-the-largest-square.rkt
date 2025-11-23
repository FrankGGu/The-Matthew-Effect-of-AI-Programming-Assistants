(define (count-good-rectangles rectangles)
  (let* ([max-side (apply max (map min rectangles))]
         [count (length (filter (lambda (rect) (>= (min rect) max-side)) rectangles))])
    count))