(define (sorted-squares nums)
  (sort (map (lambda (x) (* x x)) nums) <))