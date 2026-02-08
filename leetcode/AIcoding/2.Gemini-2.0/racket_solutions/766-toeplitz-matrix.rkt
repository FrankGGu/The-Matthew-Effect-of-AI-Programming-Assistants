(define (is-toeplitz-matrix matrix)
  (let ([rows (length matrix)]
        [cols (length (car matrix))])
    (letrec ([check-toeplitz? (lambda (row col)
                                  (or (and (>= row rows) (>= col cols))
                                      (and (< row rows) (< col cols)
                                           (= (list-ref (list-ref matrix row) col)
                                              (list-ref (list-ref matrix 0) 0))
                                           (check-toeplitz? (+ row 1) (+ col 1)))))]
             [check-row (lambda (row)
                          (or (>= row rows)
                              (and (check-toeplitz? row 0)
                                   (check-row (+ row 1)))))]
             [check-col (lambda (col)
                          (or (>= col cols)
                              (and (check-toeplitz? 0 col)
                                   (check-col (+ col 1)))))]
             )
      (and (check-row 0) (check-col 0)))))