(define (can-reverse? target nums)
  (equal? (sort target <) (sort nums <)))