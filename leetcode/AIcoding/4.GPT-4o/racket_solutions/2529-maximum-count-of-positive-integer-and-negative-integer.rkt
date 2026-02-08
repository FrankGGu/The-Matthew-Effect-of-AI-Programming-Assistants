(define (maximumCount nums)
  (let ((positive-count (length (filter (lambda (x) (> x 0)) nums)))
        (negative-count (length (filter (lambda (x) (< x 0)) nums))))
    (max positive-count negative-count)))