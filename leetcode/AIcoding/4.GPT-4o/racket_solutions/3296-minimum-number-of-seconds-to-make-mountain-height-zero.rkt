(define (minSecondsToMakeMountainHeightZero A)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define (lcm a b)
    (/ (* a b) (gcd a b)))
  (define n (length A))
  (define l (foldl lcm 1 A))
  (define total (foldl + 0 A))
  (if (= total 0)
      0
      (quotient l total)))

(define (minimumSeconds A)
  (minSecondsToMakeMountainHeightZero A))