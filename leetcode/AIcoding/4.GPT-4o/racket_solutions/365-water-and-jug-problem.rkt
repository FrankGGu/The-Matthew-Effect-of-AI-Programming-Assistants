(define (canMeasureWater jug1 jug2 target)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (or (= target 0)
      (and (<= target (+ jug1 jug2))
           (= (modulo target (gcd jug1 jug2)) 0))))