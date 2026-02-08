(define (minOperations arr)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define overall-gcd (foldl gcd 0 arr))
  (if (= overall-gcd 0)
      0
      (length arr)))