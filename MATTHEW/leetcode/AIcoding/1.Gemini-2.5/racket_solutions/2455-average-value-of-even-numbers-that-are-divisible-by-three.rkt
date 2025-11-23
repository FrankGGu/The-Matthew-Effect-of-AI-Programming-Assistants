(define (average-value nums)
  (let* ([filtered-nums (filter (lambda (n) (and (= (modulo n 2) 0) (= (modulo n 3) 0)))
                                nums)]
         [count (length filtered-nums)])
    (if (= count 0)
        0
        (quotient (apply + filtered-nums) count))))