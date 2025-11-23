(define (min-path-cost grid moveCost)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define dp (build-vector m (lambda (r) (build-vector n (lambda (c) 0)))))

  (for ([c (in-range n)])
    (vector-set! (vector-ref dp 0) c (vector-ref (vector-ref grid 0) c)))

  (for ([r (in-range 1 m)])
    (for ([c (in-range n)])
      (define current-cell-value (vector-ref (vector-ref grid r) c))
      (define min-cost-from-prev-row +inf.0)
      (for ([prev-c (in-range n)])
        (define value-in-prev-cell (vector-ref (vector-ref grid (- r 1)) prev-c))
        (define cost-to-move-to-current-col (vector-ref (vector-ref moveCost value-in-prev-cell) c))
        (define total-cost-through-prev-cell (+ (vector-ref (vector-ref dp (- r 1)) prev-c)
                                               cost-to-move-to-current-col))
        (set! min-cost-from-prev-row (min min-cost-from-prev-row total-cost-through-prev-cell)))
      (vector-set! (vector-ref dp r) c (+ current-cell-value min-cost-from-prev-row))))

  (define min-total-cost +inf.0)
  (for ([c (in-range n)])
    (set! min-total-cost (min min-total-cost (vector-ref (vector-ref dp (- m 1)) c))))

  min-total-cost)