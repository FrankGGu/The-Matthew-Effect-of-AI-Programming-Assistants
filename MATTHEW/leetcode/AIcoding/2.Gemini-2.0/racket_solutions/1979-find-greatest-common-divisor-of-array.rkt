(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (findGCD nums)
  (let* ([min-num (apply min nums)]
         [max-num (apply max nums)])
    (gcd min-num max-num)))