(define (mechanical-accumulator-1 target)
  (let loop ([n 1] [sum 0])
    (cond
      [(> sum target) -1]
      [(= sum target) n]
      [else (loop (add1 n) (+ sum n))])))