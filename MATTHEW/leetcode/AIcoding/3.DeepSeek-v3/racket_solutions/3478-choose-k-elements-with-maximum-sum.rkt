(define (maximum-sum nums k)
  (let loop ([nums (sort nums >)] [sum 0] [k k])
    (if (or (null? nums) (zero? k))
        sum
        (loop (cdr nums) (+ sum (car nums)) (sub1 k)))))