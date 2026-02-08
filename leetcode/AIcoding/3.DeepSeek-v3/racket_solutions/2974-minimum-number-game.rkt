(define/contract (number-game nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([sorted-nums (sort nums <)]
         [pairs (partition-all sorted-nums 2)])
    (flatten (for/list ([pair pairs])
               (reverse pair)))))