(define (count-partitions nums)
  (let* ([total (apply + nums)]
         [n (length nums)]
         [target (quotient total 2)])
    (if (odd? total)
        0
        (let loop ([i 0] [sum 0] [count 0])
          (cond
            [(= i n) (if (= sum target) (add1 count) count)]
            [else (loop (add1 i) (+ sum (list-ref nums i)) 
                        (loop (add1 i) sum count))])))))