(define/contract (can-make-arithmetic-progression arr)
  (-> (listof exact-integer?) boolean?)
  (let* ([sorted-arr (sort arr <)]
         [diff (- (second sorted-arr) (first sorted-arr))])
    (for/and ([i (in-range 1 (sub1 (length sorted-arr)))])
      (equal? (- (list-ref sorted-arr (add1 i)) (list-ref sorted-arr i)) diff))))