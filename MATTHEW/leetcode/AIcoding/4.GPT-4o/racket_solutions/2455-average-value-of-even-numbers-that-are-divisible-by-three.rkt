(define (averageValue nums)
  (define even-divisible (filter (lambda (x) (and (= (modulo x 2) 0) (= (modulo x 3) 0))) nums))
  (if (null? even-divisible)
      0
      (round (/ (apply + even-divisible) (length even-divisible)))))