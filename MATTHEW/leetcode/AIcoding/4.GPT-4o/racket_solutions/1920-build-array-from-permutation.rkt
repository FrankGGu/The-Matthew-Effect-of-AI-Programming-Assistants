(define (buildArray perm)
  (map (lambda (i) (list-ref perm i)) (range (length perm))))