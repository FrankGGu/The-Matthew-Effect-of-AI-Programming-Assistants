(define/contract (number-of-employees-zero-time target hours)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (length (filter (lambda (h) (>= h target)) hours)))