(define (maxDistinctPrimes n)
  (define (prime-factors x)
    (define (factors p x)
      (if (= x 1) '()
          (if (= (modulo x p) 0)
              (cons p (factors p (quotient x p)))
              (factors (1+ p) x))))
    (factors 2 x))

  (define distinct-primes (remove-duplicates (prime-factors n)))
  (length distinct-primes))

(maxDistinctPrimes n)