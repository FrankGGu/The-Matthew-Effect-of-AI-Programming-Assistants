(define (drop-missing-data data)
  (filter (lambda (row) (not (member '() row))) data))