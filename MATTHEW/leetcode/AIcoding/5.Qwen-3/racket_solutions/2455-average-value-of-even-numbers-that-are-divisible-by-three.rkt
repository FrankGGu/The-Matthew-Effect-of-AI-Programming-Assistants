(define (average-value nums)
  (define even-div3 (filter (lambda (x) (and (even? x) (= (remainder x 3) 0))) nums))
  (if (null? even-div3)
      0
      (/ (apply + even-div3) (length even-div3))))