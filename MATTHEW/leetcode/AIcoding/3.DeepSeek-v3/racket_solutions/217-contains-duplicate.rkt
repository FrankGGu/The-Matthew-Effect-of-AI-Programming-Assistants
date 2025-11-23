(define/contract (contains-duplicate nums)
  (-> (listof exact-integer?) boolean?)
  (not (equal? (length nums) (length (remove-duplicates nums)))))