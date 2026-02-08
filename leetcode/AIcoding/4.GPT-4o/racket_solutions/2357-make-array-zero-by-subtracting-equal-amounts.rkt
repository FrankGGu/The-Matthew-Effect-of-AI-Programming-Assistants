(define (minimumOperations nums)
  (define unique-numbers (remove (lambda (x) (= x 0)) (remove-duplicates nums)))
  (length unique-numbers))

(minimumOperations '(1 5 0 3 5))