(define (minimum-operations nums)
  (define positive-nums (filter (lambda (x) (> x 0)) nums))
  (define unique-positive-nums (list->set positive-nums))
  (set-count unique-positive-nums))