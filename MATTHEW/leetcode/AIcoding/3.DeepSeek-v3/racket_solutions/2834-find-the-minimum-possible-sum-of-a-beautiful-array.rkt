(define/contract (minimum-possible-sum n target)
  (-> exact-integer? exact-integer? exact-integer?)
  (let loop ([i 1] [sum 0] [used (set)] [count 0])
    (if (= count n)
        sum
        (if (set-member? used (- target i))
            (loop (add1 i) sum used count)
            (loop (add1 i) (+ sum i) (set-add used i) (add1 count))))))