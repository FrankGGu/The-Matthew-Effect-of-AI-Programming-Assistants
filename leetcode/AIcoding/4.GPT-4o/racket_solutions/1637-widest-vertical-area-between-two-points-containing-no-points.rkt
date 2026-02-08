(define (max-width-of-vertical-area points)
  (define sorted-x (sort (map car points) <))
  (define widths (map - (cdr sorted-x) sorted-x))
  (apply max widths))

(max-width-of-vertical-area '((8,7) (9,9) (7,4) (2,3)))