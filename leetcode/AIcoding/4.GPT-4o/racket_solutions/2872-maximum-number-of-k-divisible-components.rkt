(define (maxKDivisibleComponents nums k)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (mod a b))))
  (define (count-k-divisible comp)
    (if (null? comp)
        0
        (if (zero? (gcd (car comp) k))
            (+ 1 (count-k-divisible (cdr comp)))
            (count-k-divisible (cdr comp)))))
  (count-k-divisible nums))

(maxKDivisibleComponents '(2 3 4 6 5) 2)