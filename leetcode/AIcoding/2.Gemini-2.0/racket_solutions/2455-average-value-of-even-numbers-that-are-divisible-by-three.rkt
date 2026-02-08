(define (average-value nums)
  (let loop ([nums nums] [sum 0] [count 0])
    (cond
      [(empty? nums)
       (if (zero? count)
           0
           (floor (/ sum count)))]
      [else
       (let ([first (first nums)])
         (if (and (even? first) (zero? (modulo first 3)))
             (loop (rest nums) (+ sum first) (+ count 1))
             (loop (rest nums) sum count)))])))