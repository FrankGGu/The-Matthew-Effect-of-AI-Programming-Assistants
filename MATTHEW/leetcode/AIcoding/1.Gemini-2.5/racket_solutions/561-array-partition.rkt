(define (array-pair-sum nums)
  (let* ([sorted-nums (sort nums <)])
    (let loop ([lst sorted-nums] [sum 0])
      (cond
        [(empty? lst) sum]
        [(empty? (rest lst)) sum]
        [else (loop (rest (rest lst)) (+ sum (first lst)))]))))