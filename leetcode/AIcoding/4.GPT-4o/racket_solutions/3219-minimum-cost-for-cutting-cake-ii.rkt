(define (minCostCuttingCake n cuts)
  (define (dp left right)
    (if (>= left right)
        0
        (let loop ([i left] [min-cost +inf.0])
          (if (> i right)
              min-cost
              (loop (+ i 1) (min min-cost (+ (- (list-ref cuts right) (list-ref cuts left))
                                              (dp left (- i 1))
                                              (dp (+ i 1) right))))))))
  (define cuts (sort (cons 0 (cons n cuts)) <))
  (dp 0 (sub1 (length cuts))))

(define (minCost cuts n)
  (minCostCuttingCake n cuts))