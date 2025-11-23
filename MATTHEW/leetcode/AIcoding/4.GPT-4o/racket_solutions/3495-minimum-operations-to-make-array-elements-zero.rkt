(define (minimumOperations nums)
  (define unique-nums (remove-duplicates (filter (lambda (x) (not (= x 0))) nums)))
  (length unique-nums))

(minimumOperations '(3 3 2 2 4 0 0)) ; Example test case