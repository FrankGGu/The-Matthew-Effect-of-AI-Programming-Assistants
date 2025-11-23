(define (minDifference nums)
  (let ([n (length nums)])
    (if (<= n 4)
        0
        (let ([sorted-nums (sort nums <)])
          (min (list (- (list-ref sorted-nums (- n 1)) (list-ref sorted-nums 3))
                     (- (list-ref sorted-nums (- n 2)) (list-ref sorted-nums 2))
                     (- (list-ref sorted-nums (- n 3)) (list-ref sorted-nums 1))
                     (- (list-ref sorted-nums (- n 4)) (list-ref sorted-nums 0))))))))