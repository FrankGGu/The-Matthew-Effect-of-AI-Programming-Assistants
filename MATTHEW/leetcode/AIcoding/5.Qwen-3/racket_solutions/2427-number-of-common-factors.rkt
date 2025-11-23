(define (common-factors a b)
  (define (gcd x y)
    (if (= y 0)
        x
        (gcd y (modulo x y))))
  (define g (gcd a b))
  (define (count-divisors n)
    (let loop ((i 1) (count 0))
      (if (> i n)
          count
          (loop (+ i 1) (if (= (modulo n i) 0) (+ count 1) count)))))
  (count-divisors g))