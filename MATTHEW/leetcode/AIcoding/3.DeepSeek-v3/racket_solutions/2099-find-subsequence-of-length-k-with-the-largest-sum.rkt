(define/contract (max-subsequence nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([indexed (map cons nums (range (length nums)))]
         [sorted (sort indexed > #:key car)]
         [top-k (take sorted k)]
         [sorted-by-index (sort top-k < #:key cdr)])
    (map car sorted-by-index)))