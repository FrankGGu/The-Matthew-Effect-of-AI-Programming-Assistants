(define/contract (build-array nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (for/list ([i nums])
    (list-ref nums i)))