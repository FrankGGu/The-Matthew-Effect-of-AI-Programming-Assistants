(define (simplified-fractions n)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define result '())
  (for ([numerator (in-range 1 n)])
    (for ([denominator (in-range (+ numerator 1) (+ n 1))])
      (when (= (gcd numerator denominator) 1)
        (set! result (cons (format "~a/~a" numerator denominator) result)))))
  (reverse result))

(define (simplified-fractions-main n)
  (simplified-fractions n))