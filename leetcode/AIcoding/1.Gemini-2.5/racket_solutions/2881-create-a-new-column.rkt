(define (create-new-column matrix)
  (map (lambda (row)
         (append row (list (+ (first row) (second row)))))
       matrix))