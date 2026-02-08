(define/contract (minimize-array-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [prefix-sum 0] [max-avg 0] [i 0])
    (if (null? nums)
        max-avg
        (let* ([prefix-sum (+ prefix-sum (car nums))]
               [current-avg (ceiling (/ prefix-sum (+ i 1)))])
          (loop (cdr nums) prefix-sum (max max-avg current-avg) (+ i 1))))))