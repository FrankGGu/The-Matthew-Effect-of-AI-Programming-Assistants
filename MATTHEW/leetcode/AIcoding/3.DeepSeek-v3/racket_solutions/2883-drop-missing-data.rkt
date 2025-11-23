(define (drop-missing-data df)
  (filter (lambda (row) (not (member 'None row))) df)