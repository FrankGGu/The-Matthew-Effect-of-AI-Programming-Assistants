(define (maximum-number-of-consecutive-values xs)
  (let loop ([coins (sort xs <)]
             [max-reachable 0])
    (cond
      [(empty? coins) (add1 max-reachable)]
      [(<= (first coins) (add1 max-reachable))
       (loop (rest coins) (+ max-reachable (first coins)))]
      [else (add1 max-reachable)])))