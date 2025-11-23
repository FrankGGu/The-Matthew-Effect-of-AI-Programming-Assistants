(define/contract (max-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort nums >)]
         [a (first sorted)]
         [b (second sorted)])
    (* (- a 1) (- b 1))))