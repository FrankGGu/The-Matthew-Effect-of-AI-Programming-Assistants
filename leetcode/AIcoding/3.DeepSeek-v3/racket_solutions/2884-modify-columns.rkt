(define (modify-columns rows)
  (map (lambda (row)
         (list-set row 1 (if (>= (list-ref row 1) 50) 100 0)))
       rows))