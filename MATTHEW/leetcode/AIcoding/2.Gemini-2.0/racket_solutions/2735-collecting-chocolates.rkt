(define (minCostToCollectChocolates costs)
  (define n (vector-length costs))
  (define (solve current-costs)
    (define min-cost (apply min current-costs))
    (cond
      [(empty? current-costs) 0]
      [else (+ min-cost (solve (vector->list (vector-map (lambda (x) (- x min-cost)) current-costs))))]))
  (solve (vector->list costs)))