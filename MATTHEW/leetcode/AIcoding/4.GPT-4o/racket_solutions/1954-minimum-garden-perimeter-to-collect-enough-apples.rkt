(define (minimum-perimeter apples)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (lcm a b)
    (/ (* a b) (gcd a b)))

  (define n (ceiling (sqrt (/ apples 2.0))))
  (define perimeter (* 8 (+ n n)))
  perimeter)