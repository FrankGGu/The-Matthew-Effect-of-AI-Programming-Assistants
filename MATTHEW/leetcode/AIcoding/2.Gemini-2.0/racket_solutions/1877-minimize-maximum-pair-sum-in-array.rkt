(define (minPairSum nums)
  (let* ([sorted-nums (sort nums <)])
    (let loop ([i 0] [j (- (length sorted-nums) 1)] [max-sum 0])
      (if (>= i j)
          max-sum
          (let ([current-sum (+ (list-ref sorted-nums i) (list-ref sorted-nums j))])
            (loop (+ i 1) (- j 1) (max max-sum current-sum)))))))