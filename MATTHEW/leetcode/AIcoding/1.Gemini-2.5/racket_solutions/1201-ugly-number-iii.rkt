(define (gcd x y)
  (if (= y 0)
      x
      (gcd y (remainder x y))))

(define (lcm x y)
  (if (or (= x 0) (= y 0))
      0
      (/ (* x y) (gcd x y))))

(define (lcm3 x y z)
  (lcm (lcm x y) z))

(define (count-ugly-numbers num a b c)
  (define ca (floor (/ num a)))
  (define cb (floor (/ num b)))
  (define cc (floor (/ num c)))

  (define cab (floor (/ num (lcm a b))))
  (define cac (floor (/ num (lcm a c))))
  (define cbc (floor (/ num (lcm b c))))

  (define cabc (floor (/ num (lcm3 a b c))))

  (+ ca cb cc (- cab) (- cac) (- cbc) cabc))

(define (nth-ugly-number n a b c)
  (let loop ((low 1) (high 2000000000000000000) (ans high)) ; Upper bound 2 * 10^18
    (if (> low high)
        ans
        (let* ((mid (floor (/ (+ low high) 2)))
               (count (count-ugly-numbers mid a b c)))
          (if (>= count n)
              (loop low (- mid 1) mid)
              (loop (+ mid 1) high ans))))))