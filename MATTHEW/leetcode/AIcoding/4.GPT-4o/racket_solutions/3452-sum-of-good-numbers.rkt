(define (sumOfGoodNumbers n)
  (define (mod x) (remainder x (+ 10^9 7)))
  (define even-count (mod (/ n 2)))
  (define odd-count (mod (if (even? n) even-count (add1 even-count))))
  (define even-ways (mod (expt 5 even-count)))
  (define odd-ways (mod (expt 4 odd-count)))
  (mod (* even-ways odd-ways)))

(sumOfGoodNumbers n)