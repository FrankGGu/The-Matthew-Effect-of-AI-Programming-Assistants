(define (maximum-element-after-decreasing-and-rearranging arr)
  (let ([sorted-arr (sort arr <)])
    (foldl (lambda (x current-max)
             (min x (add1 current-max)))
           0
           sorted-arr)))