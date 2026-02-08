(define (dataframe-size df)
  (let* ((rows (length df))
         (cols (if (empty? df)
                   0
                   (length (car df)))))
    (list rows cols)))