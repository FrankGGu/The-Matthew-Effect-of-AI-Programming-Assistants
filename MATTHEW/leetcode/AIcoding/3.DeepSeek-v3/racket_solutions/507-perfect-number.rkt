(define/contract (check-perfect-number num)
  (-> exact-integer? boolean?)
  (if (<= num 1)
      #f
      (let loop ([sum 1] [i 2])
        (cond
          [(> (* i i) num) (= sum num)]
          [(= (modulo num i) 0)
           (let ([j (/ num i)])
             (if (= i j)
                 (loop (+ sum i) (+ i 1))
                 (loop (+ sum i j) (+ i 1))))]
          [else (loop sum (+ i 1))]))))