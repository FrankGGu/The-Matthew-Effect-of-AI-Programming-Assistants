(define (findGCD nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define min (apply min nums))
  (define max (apply max nums))
  (gcd min max))