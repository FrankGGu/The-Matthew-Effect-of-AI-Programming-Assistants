(define (sum-base n k)
  (if (= n 0)
      0
      (+ (remainder n k) (sum-base (quotient n k) k))))