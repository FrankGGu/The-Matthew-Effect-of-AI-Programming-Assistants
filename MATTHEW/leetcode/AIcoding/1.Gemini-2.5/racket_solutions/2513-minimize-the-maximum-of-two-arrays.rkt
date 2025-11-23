#lang racket

(define (gcd a b)
  (if (zero? b)
      a
      (gcd b (modulo a b))))

(define (lcm a b)
  (if (or (zero? a) (zero? b))
      0 ; Not reachable with problem constraints (divisors >= 1)
      (/ (* a b) (gcd a b))))

(define (minimize-the-maximum-of-two-arrays divisor1 divisor2 uniqueCnt1 uniqueCnt2)

  (define (check x)
    (define num1-ok (- x (floor-quotient x divisor1)))
    (define num2-ok (- x (floor-quotient x divisor2)))
    (define common-lcm (lcm divisor1 divisor2))
    (define num-both-ok (- x (floor-quotient x common-lcm)))

    (and (>= num1-ok uniqueCnt1)
         (>= num2-ok uniqueCnt2)
         (>= num-both-ok (+ uniqueCnt1 uniqueCnt2))))

  (let loop ((low 1) (high 400000) (ans 400000))
    (if (> low high)
        ans
        (let* ((mid (+ low (floor (/ (- high low) 2)))))
          (if (check mid)
              (loop low (- mid 1) mid)
              (loop (+ mid 1) high ans))))))