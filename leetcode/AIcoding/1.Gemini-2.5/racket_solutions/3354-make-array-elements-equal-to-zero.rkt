(define (minimum-operations nums)
  (define positive-nums (filter (lambda (x) (> x 0)) nums))
  (define unique-positive-nums (remove-duplicates positive-nums))
  (length unique-positive-nums))