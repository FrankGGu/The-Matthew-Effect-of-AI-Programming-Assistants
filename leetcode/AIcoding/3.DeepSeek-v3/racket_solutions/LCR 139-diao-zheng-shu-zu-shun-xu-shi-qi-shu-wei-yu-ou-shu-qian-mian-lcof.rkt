(define/contract (training-plan actions cnt)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (take actions cnt))