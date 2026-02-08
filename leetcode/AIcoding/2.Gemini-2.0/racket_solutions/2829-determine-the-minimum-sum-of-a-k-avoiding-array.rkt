(define (minimum-sum k n)
  (let loop ([i 1] [count 0] [sum 0])
    (cond
      [(= count n) sum]
      [(< i k) (loop (+ i 1) (+ count 1) (+ sum i))]
      [else (loop (+ i 1) (+ count 1) (+ sum i))])))