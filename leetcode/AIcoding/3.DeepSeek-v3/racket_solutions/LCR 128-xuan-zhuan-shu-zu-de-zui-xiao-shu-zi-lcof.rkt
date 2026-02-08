(define/contract (stock-management stock)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? stock)
      -1
      (apply min stock)))