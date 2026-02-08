(define (get-dataframe-size rows)
  (list (length rows) (if (null? rows) 0 (length (car rows)))))