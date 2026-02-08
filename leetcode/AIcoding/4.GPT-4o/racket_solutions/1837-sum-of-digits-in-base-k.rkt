(define (sumOfDigits n k)
  (define (digit-sum x)
    (if (= x 0)
        0
        (+ (modulo x 10) (digit-sum (quotient x 10)))))
  (define (base-k-sum x base)
    (if (= x 0)
        0
        (+ (modulo x base) (base-k-sum (quotient x base) base))))
  (if (= (digit-sum n) 1)
      1
      (base-k-sum n k)))