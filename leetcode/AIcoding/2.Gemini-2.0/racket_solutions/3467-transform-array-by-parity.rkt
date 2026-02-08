(define (sort-array-by-parity nums)
  (append (filter even? nums) (filter odd? nums)))