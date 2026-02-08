(define/contract (sorted-squares nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (sort (map (lambda (x) (* x x)) nums) <))