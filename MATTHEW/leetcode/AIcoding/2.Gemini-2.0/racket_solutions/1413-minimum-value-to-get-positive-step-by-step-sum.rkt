(define (min-start-value nums)
  (let loop ([nums nums] [sum 0] [min-sum 0])
    (cond
      [(empty? nums)
       (max 1 (- min-sum) )]
      [else
       (let ([new-sum (+ sum (car nums))])
         (loop (cdr nums) new-sum (min min-sum new-sum)))])))