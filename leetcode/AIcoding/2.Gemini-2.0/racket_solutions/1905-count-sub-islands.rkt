(define (count-sub-islands grid1 grid2)
  (define rows (vector-length grid1))
  (define cols (vector-length (vector-ref grid1 0)))

  (define (is-valid? row col)
    (and (>= row 0) (< row rows) (>= col 0) (< col cols)))

  (define (dfs row col)
    (cond
      [(not (is-valid? row col)) #t]
      [(zero? (vector-ref (vector-ref grid2 row) col)) #t]
      [(zero? (vector-ref (vector-ref grid1 row) col)) #f]
      [else
       (vector-set! (vector-ref grid2 row) col 0)
       (and (dfs (+ row 1) col)
            (dfs (- row 1) col)
            (dfs row (+ col 1))
            (dfs row (- col 1)))]))

  (let loop ([row 0] [col 0] [count 0])
    (cond
      [(= row rows) count]
      [(= col cols) (loop (+ row 1) 0 count)]
      [(zero? (vector-ref (vector-ref grid2 row) col)) (loop row (+ col 1) count)]
      [else (if (dfs row col)
                (loop row (+ col 1) (+ count 1))
                (loop row (+ col 1) count))]))
  )