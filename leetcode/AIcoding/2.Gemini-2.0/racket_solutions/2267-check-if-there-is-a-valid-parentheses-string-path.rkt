(define (has-valid-path grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define (valid-index? row col)
    (and (>= row 0) (< row m) (>= col 0) (< col n)))

  (define (solve row col balance)
    (cond
      [(not (valid-index? row col)) #f]
      [(= (vector-ref (vector-ref grid row) col) #\() (solve-helper row col (+ balance 1))]
      [(= (vector-ref (vector-ref grid row) col) #\)) (solve-helper row col (- balance 1))]
      [else #f]))

  (define (solve-helper row col balance)
    (cond
      [(< balance 0) #f]
      [(and (= row (- m 1)) (= col (- n 1))) (= balance 0)]
      [else (or (solve (+ row 1) col balance) (solve row (+ col 1) balance))]))

  (solve 0 0 0))