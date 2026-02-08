(define (min-array-end nums)
  (if (null? nums)
      0
      (foldl min (car nums) (cdr nums))))

(min-array-end '(3 4 5 1 2)) ; should return 1