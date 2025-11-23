(define (drop-missing-data dt col-name)
  (table-select dt (lambda (row) (not (equal? (dict-ref row col-name) #f)))))