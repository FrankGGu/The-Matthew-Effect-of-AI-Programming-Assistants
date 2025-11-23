(define (minimumOperations nums)
  (define unique-numbers (remove-duplicates (filter (lambda (x) (> x 0)) nums)))
  (length unique-numbers))

(minimumOperations '(3 2 2 4 3))