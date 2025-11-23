(define (minOperations(target)
  (define n (/ target 2))
  (define total (- (* n (+ 1 n)) (* n n)))
  (define ops (if (even? target) n (+ n 1)))
  ops)

(define (minOperationsToTarget arr)
  (minOperations (apply + arr)))