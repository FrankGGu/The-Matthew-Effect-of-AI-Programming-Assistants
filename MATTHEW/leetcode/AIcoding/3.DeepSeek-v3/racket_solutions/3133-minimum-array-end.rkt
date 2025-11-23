(define/contract (minimize-array-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [max-val 0] [sum 0] [count 0])
    (if (null? nums)
        max-val
        (let* ([num (car nums)]
               [new-sum (+ sum num)]
               [new-count (+ count 1)]
               [current-avg (ceiling (/ new-sum new-count))])
          (loop (cdr nums) (max max-val current-avg) new-sum new-count)))))