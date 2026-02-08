(define (minNonZeroProduct p)
  (define mod (expt 10 9))
  (define max (sub1 (expt 2 p)))
  (define (power a b)
    (if (= b 0)
        1
        (modulo (* a (power a (sub1 b))) mod)))
  (modulo (* max (power (sub1 max) (quotient (expt 2 p) 1))) mod))