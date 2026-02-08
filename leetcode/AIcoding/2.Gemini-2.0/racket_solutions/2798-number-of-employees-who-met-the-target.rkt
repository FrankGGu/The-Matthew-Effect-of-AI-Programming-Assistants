(define (number-of-employees-who-met-target employees target)
  (length (filter (lambda (x) (>= x target)) employees)))