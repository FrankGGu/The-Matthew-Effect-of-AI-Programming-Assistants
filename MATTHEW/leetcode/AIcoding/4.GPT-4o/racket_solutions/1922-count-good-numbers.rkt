(define (countGoodNumbers n)
  (define mod (expt 10 9))
  (define even-count (expt 5 (quotient n 2)))
  (define odd-count (expt 4 (quotient (+ n 1) 2)))
  (modulo (* even-count odd-count) mod))

(countGoodNumbers n)