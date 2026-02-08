(define (pivot-integer n)
  (let loop ([i 1]
             [sum-left 0]
             [sum-right (sum (range 1 (+ n 1)))])
    (cond
      [(= sum-left sum-right) i]
      [(> i n) -1]
      [else (loop (+ i 1) (+ sum-left i) (- sum-right i))])))