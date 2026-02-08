(define (findBall grid)
  (define (fall ball col)
    (if (>= col 0)
      (if (< col (length grid))
        (let ((next-col (if (equal? (vector-ref (vector-ref grid 0) col) 1)
                            (+ col 1)
                            (- col 1))))
          (if (and (equal? (vector-ref (vector-ref grid 0) col) 1)
                   (< next-col (length grid)))
            (if (equal? (vector-ref (vector-ref grid 0) next-col) -1)
                -1
                (fall ball next-col))
            -1))
        -1)
      -1))

  (define (drop-ball col)
    (fall 0 col))

  (define cols (length (vector-ref grid 0)))
  (define results (make-vector cols -1))

  (for ((i (in-range cols)))
    (vector-set! results i (drop-ball i)))

  (vector->list results))