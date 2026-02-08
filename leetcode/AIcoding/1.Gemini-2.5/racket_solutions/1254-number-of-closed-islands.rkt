#lang racket

(define (closed-island grid)
  (define m (length grid))
  (if (zero? m)
      0
      (begin
        (define n (length (car grid)))

        (define mutable-grid (make-vector m))
        (for ([i (in-range m)])
          (vector-set! mutable-grid i (list->vector (list-ref grid i))))

        (define (dfs row col)
          (when (and (>= row 0) (< row m)
                     (>= col 0) (< col n)
                     (= (vector-ref (vector-ref mutable-grid row) col) 0))
            (vector-set! (vector-ref mutable-grid row) col 1)
            (dfs (+ row 1) col)
            (dfs (- row 1) col)
            (dfs row (+ col 1))
            (dfs row (- col 1))))

        (for ([j (in-range n)])
          (dfs 0 j)
          (dfs (- m 1) j))

        (for ([i (in-range m)])
          (dfs i 0)
          (dfs i (- n 1)))

        (define closed-islands-count 0)
        (for ([i (in-range m)])
          (for ([j (in-range n)])
            (when (= (vector-ref (vector-ref mutable-grid i) j) 0)
              (set! closed-islands-count (+ closed-islands-count 1))
              (dfs i j))))

        closed-islands-count)))