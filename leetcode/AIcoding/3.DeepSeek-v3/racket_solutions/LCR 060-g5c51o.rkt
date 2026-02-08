(define/contract (top-k-frequent nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([freq (make-hash)]
         [sorted (sort nums <)]
         [n (length nums)]
         [i 0])
    (for ([num sorted])
      (hash-update! freq num add1 (λ () 0)))
    (let ([sorted-freq (sort (hash->list freq) (λ (x y) (> (cdr x) (cdr y))))])
      (take (map car sorted-freq) k))))