(define/contract (distinct-difference-array nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (for/list ([i (in-range (length nums))])
    (let* ([prefix (take nums (add1 i))]
           [suffix (drop nums (add1 i))]
           [prefix-count (length (remove-duplicates prefix))]
           [suffix-count (length (remove-duplicates suffix))])
      (- prefix-count suffix-count))))