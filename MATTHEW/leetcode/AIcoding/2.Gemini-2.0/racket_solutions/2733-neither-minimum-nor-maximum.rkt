(define (find-non-min-or-max nums)
  (cond
    [(< (length nums) 3) -1]
    [else
     (let ([sorted-nums (sort nums <)])
       (list-ref sorted-nums 1))]))