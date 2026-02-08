(define (difference element-sum digit-sum)
  (abs (- element-sum digit-sum)))

(define (digit-sum n)
  (if (< n 10)
      n
      (+ (modulo n 10) (digit-sum (quotient n 10)))))

(define (sum-digits nums)
  (foldl + 0 (map digit-sum nums)))

(define (array-sign nums)
  (difference (foldl + 0 nums) (sum-digits nums)))