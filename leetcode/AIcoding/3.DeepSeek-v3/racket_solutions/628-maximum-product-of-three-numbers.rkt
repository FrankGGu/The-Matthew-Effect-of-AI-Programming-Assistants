(define/contract (maximum-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort nums <)]
         [n (length sorted)]
         [a (* (list-ref sorted (- n 1))
               (list-ref sorted (- n 2))
               (list-ref sorted (- n 3)))]
         [b (* (list-ref sorted 0)
               (list-ref sorted 1)
               (list-ref sorted (- n 1)))])
    (max a b)))