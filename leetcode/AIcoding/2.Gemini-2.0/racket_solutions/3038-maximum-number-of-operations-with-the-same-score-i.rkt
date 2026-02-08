(define (maxOperations nums)
  (define n (length nums))
  (if (< n 2)
      0
      (let loop ([i 2] [count 1] [target (+ (list-ref nums 0) (list-ref nums 1))])
        (if (>= i n)
            count
            (if (= target (+ (list-ref nums i) (list-ref nums (+ i 1))))
                (loop (+ i 2) (+ count 1) target)
                count)))))