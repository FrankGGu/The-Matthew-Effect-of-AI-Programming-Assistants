(define (count-even num)
  (define (digit-sum n)
    (let loop ((val n) (sum 0))
      (if (zero? val)
          sum
          (loop (quotient val 10) (+ sum (remainder val 10))))))

  (let loop ((i 1) (count 0))
    (if (> i num)
        count
        (loop (add1 i)
              (if (even? (digit-sum i))
                  (add1 count)
                  count)))))