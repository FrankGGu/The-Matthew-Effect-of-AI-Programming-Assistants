(define (create-dataframe student-data)
  (define columns (car student-data))
  (define rows (cdr student-data))
  (make-hash
   (for/list ([col columns]
              [i (in-naturals)])
     (cons col
           (for/list ([row rows])
             (list-ref row i))))))