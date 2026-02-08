(define (countHousePlacements n)
  (define mod 1000000007)
  (define (power a b)
    (if (= b 0)
        1
        (modulo (* a (power a (- b 1))) mod)))
  (define ways (power 2 n))
  (modulo (power ways 2) mod))

(define (numWays n)
  (countHousePlacements n))