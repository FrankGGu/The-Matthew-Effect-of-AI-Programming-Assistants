(define (max-sum nums k)
  (define sorted (sort nums >))
  (apply + (take sorted k)))

(define (chooseKElementsWithMaximumSum nums k)
  (max-sum nums k))