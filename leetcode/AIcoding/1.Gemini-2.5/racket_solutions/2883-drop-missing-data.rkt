(define (drop-missing-data data)
  (filter (lambda (x) (not (null? x))) data))