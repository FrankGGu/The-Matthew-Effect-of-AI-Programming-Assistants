(define (check-if-every-row-and-column-contains-all-numbers matrix)
  (let* ([n (length matrix)]
         [row-sets (map (lambda (row) (set (in-list row))) matrix)]
         [col-sets (map (lambda (col) (set (in-list col)))
                        (apply map list matrix))]
         [expected-set (set (in-range 1 (+ n 1)))]
         [check-row (lambda (row-set) (equal? row-set expected-set))]
         [check-col (lambda (col-set) (equal? col-set expected-set))])
    (andmap check-row row-sets) (andmap check-col col-sets)))