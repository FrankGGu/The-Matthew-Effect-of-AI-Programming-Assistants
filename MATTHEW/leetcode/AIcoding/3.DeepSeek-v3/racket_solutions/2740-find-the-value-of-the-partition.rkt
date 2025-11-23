(define/contract (find-value-of-partition nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([sorted-nums (sort nums <)])
    (let loop ([i 1] [min-diff (- (list-ref sorted-nums 1) (list-ref sorted-nums 0))])
      (if (>= i (length sorted-nums))
          min-diff
          (let ([current-diff (- (list-ref sorted-nums i) (list-ref sorted-nums (- i 1)))])
            (loop (+ i 1) (min min-diff current-diff)))))))