(define (minimumTimeToBreakLocks A B)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define lcm (lambda (a b) (/ (* a b) (gcd a b))))
  (define min-time (apply lcm A))
  (for/sum ((b B))
    (if (= (modulo min-time b) 0)
        min-time
        (+ min-time b)))
)

(minimumTimeToBreakLocks '(2 3) '(3 5))