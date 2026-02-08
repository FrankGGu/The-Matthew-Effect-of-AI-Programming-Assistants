(define/contract (split-array nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [sum1 0] [sum2 (foldl + 0 nums)])
    (if (null? nums)
        -1
        (let ([sum1 (+ sum1 (car nums))]
              [sum2 (- sum2 (car nums))])
          (if (= sum1 sum2)
              (length nums)
              (loop (cdr nums) sum1 sum2))))))