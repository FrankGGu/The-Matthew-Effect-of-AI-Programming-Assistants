(define (canBeSorted nums)
  (define sorted-nums (sort nums <))
  (equal? nums sorted-nums))

(define (check-array nums)
  (if (canBeSorted nums)
      #t
      #f))