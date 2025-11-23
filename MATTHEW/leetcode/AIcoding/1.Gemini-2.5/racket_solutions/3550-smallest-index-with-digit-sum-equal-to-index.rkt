(define (smallest-equal-index nums)
  (let ([result (for/first ([i (in-range (length nums))]
                             [val (in-list nums)]
                             #:when (= (remainder i 10) val))
                  i)])
    (if result
        result
        -1)))