(define (number-of-employees-who-met-target hours target)
  (length (filter (lambda (h) (>= h target)) hours)))