(define (max-balanced-subsequence-sum nums)
  (define n (length nums))
  (define (solve idx prev-idx sum)
    (cond
      [(= idx n) sum]
      [(< (list-ref nums idx) (- prev-idx)) (solve (+ idx 1) prev-idx sum)]
      [else (max (solve (+ idx 1) prev-idx sum)
                 (solve (+ idx 1) idx (+ sum (list-ref nums idx))))]))
  (solve 0 -1 0))