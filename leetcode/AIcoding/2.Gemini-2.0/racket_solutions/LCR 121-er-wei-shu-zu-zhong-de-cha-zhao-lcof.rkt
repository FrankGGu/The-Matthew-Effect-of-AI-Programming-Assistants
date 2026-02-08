(define (search-matrix matrix target)
  (let* ((rows (length matrix))
         (cols (if (zero? rows) 0 (length (first matrix)))))
    (cond
      [(or (zero? rows) (zero? cols)) #f]
      [else
       (let loop ([left 0] [right (- (* rows cols) 1)])
         (cond
           [(> left right) #f]
           [else
            (let* ([mid (floor (/ (+ left right) 2))]
                   [row (floor (/ mid cols))]
                   [col (modulo mid cols)]
                   [value (list-ref (list-ref matrix row) col)])
              (cond
                [(= value target) #t]
                [(< value target) (loop (+ mid 1) right)]
                [else (loop left (- mid 1))]))]))]))))