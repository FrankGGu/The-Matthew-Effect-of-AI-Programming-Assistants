(define/contract (min-cost colors neededTime)
  (-> (listof char?) (listof exact-integer?) exact-integer?)
  (let loop ([i 1]
             [total 0]
             [max-time (first neededTime)]
             [sum-time (first neededTime)])
    (if (>= i (length colors))
        total
        (if (equal? (list-ref colors i) (list-ref colors (sub1 i)))
            (loop (add1 i)
                  total
                  (max max-time (list-ref neededTime i))
                  (+ sum-time (list-ref neededTime i)))
            (loop (add1 i)
                  (+ total (- sum-time max-time))
                  (list-ref neededTime i)
                  (list-ref neededTime i))))))