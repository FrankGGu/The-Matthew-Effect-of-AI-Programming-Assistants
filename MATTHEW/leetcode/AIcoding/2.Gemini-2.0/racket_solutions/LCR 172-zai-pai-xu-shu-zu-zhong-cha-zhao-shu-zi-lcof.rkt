(define (count-target nums target)
  (length (filter (lambda (x) (= x target)) nums)))