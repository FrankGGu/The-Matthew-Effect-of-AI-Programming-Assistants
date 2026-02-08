(define (minimum-operations-to-exceed-threshold nums k)
  (length (filter (lambda (x) (< x k)) nums)))