(define/contract (maximum-count nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([pos (count positive? nums)]
         [neg (count negative? nums)])
    (max pos neg)))