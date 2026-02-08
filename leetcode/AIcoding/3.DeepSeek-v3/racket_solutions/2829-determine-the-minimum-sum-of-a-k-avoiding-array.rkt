(define/contract (minimum-sum n k)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ([sum 0] [num 1] [count 0] [used (set)])
    (if (= count n)
        sum
        (if (set-member? used (- k num))
            (loop sum (add1 num) count used)
            (loop (+ sum num) (add1 num) (add1 count) (set-add used num))))))