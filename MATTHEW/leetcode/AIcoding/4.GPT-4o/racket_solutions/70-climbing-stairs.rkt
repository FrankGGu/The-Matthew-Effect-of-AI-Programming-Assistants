(define (climbStairs n)
  (define (helper a b n)
    (if (zero? n)
        a
        (helper b (+ a b) (sub1 n))))
  (helper 1 1 n))

(climbStairs n)