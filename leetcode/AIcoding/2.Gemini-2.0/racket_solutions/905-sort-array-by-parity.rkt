(define (sort-array-by-parity A)
  (append (filter even? A) (filter odd? A)))