(define (smallerNumbersThanCurrent nums)
  (define sorted (sort nums <))
  (map (lambda (x) (index-of sorted x)) nums))

(smallerNumbersThanCurrent '(8 1 2 2 3))