(define (sum-k-divisible-chars n k)
  (define (helper n sum)
    (if (= n 0)
        sum
        (helper (quotient n k) (+ sum (remainder n k)))))
  (helper n 0))