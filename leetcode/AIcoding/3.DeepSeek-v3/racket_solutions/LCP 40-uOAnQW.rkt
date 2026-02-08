(define/contract (max-score nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums >)] [sum 0] [count 0])
    (if (null? nums)
        sum
        (let ([new-sum (+ sum (car nums))])
          (if (positive? new-sum)
              (loop (cdr nums) new-sum (add1 count))
              (if (>= count 1)
                  sum
                  (loop (cdr nums) new-sum count)))))))