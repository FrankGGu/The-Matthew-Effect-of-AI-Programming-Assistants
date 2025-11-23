(define (is-good-array nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (= (foldl gcd (car nums) (cdr nums)) 1))