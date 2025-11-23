(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (reachable? targetX targetY)
  (= (gcd targetX targetY) 1))