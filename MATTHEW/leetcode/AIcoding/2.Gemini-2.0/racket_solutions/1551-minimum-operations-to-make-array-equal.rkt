(define (minOperations n)
  (if (odd? n)
      (/ (- (* n n) 1) 4)
      (/ (* n n) 4)))