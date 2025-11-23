(define (sort-the-students score k)
  (sort score (lambda (row1 row2)
                (> (list-ref row1 k) (list-ref row2 k)))))