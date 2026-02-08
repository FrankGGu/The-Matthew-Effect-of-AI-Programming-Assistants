(define (poor-pigs buckets minutesToDie minutesToTest)
  (define tests (quotient minutesToTest minutesToDie))
  (define pigs (if (= tests 0) 0 (ceiling (/ (log buckets) (log (+ tests 1))))))
  pigs)