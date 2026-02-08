(define (difference-between-ones-and-zeros grid)
  (define row-diffs
    (map (lambda (row)
           (apply - (map (lambda (x) (if (= x 1) 1 -1)) row)))
         grid))
  (define col-diffs
    (map (lambda (col)
           (apply - (map (lambda (x) (if (= x 1) 1 -1)) col)))
         (apply map list grid)))
  (map + row-diffs col-diffs))