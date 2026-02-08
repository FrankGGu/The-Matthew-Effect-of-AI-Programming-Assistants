(define/contract (max-product-difference nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort nums <)]
         [len (length nums)]
         [max1 (list-ref sorted (- len 1))]
         [max2 (list-ref sorted (- len 2))]
         [min1 (list-ref sorted 0)]
         [min2 (list-ref sorted 1)])
    (- (* max1 max2) (* min1 min2))))