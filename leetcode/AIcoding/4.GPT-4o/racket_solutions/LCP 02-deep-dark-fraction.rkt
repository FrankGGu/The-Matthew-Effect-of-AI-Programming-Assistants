(define (deep-dark-fraction numerator denominator)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))
  (define gcd-value (gcd numerator denominator))
  (list (/ numerator gcd-value) (/ denominator gcd-value)))

(deep-dark-fraction 1 2) ; Example usage