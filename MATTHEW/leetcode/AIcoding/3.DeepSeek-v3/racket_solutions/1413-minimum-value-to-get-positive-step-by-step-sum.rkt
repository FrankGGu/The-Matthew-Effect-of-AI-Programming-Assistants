(define/contract (min-start-value nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [sum 1] [min-sum 1])
    (if (null? nums)
        (if (<= min-sum 0) (+ 1 (- min-sum)) 1)
        (let* ([current-sum (+ sum (car nums))]
               [new-min-sum (min min-sum current-sum)])
          (loop (cdr nums) current-sum new-min-sum)))))