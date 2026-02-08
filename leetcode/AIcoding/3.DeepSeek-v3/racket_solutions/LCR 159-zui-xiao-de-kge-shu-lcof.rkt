(define/contract (inventory-management inventory cnt)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (take (sort inventory <) cnt))