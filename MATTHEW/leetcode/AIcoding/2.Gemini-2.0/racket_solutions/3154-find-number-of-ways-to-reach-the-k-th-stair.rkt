(define (num-ways n k)
  (cond
    [(< k 0) 0]
    [(= k 0) 1]
    [(< n 0) 0]
    [(= n 0) (if (= k 0) 1 0)]
    [else (+ (num-ways n (- k 1)) (num-ways n (- k 2)))]))