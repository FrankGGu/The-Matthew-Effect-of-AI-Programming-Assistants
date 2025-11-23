(define (minimum-beans-to-remove beans)
  (define total (apply + beans))
  (define min-beans (apply min beans))
  (define min-removal (apply + (filter (lambda (x) (< x min-beans)) beans)))
  (- total min-removal))

(define (removeMinimumBeans beans)
  (minimum-beans-to-remove beans))