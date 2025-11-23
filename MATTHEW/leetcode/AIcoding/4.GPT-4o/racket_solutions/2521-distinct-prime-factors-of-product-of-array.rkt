(define (distinctPrimeFactors nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (prime-factors n)
    (define (factor-helper n factor)
      (cond
        [(> factor (sqrt n)) (if (> n 1) (list n) '())]
        [(zero? (modulo n factor)) (cons factor (factor-helper (/ n factor) factor))]
        [else (factor-helper n (+ factor 1))]))
    (factor-helper n 2))

  (define all-factors
    (apply append (map prime-factors nums)))

  (define distinct-factors (set (list->vector all-factors)))
  (vector-length distinct-factors))

(define (distinctPrimeFactors nums)
  (distinctPrimeFactors nums))