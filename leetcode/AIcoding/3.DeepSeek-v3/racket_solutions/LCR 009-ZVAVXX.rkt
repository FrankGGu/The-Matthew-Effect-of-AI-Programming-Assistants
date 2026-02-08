(define/contract (num-subarray-product-less-than-k nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (if (<= k 1)
      0
      (let loop ([left 0] [right 0] [product 1] [result 0])
        (if (>= right (length nums))
            result
            (let* ([current (list-ref nums right)]
                   [new-product (* product current)])
              (if (>= new-product k)
                  (loop (add1 left) (add1 left) 1 result)
                  (loop left (add1 right) new-product (+ result (- right left) 1))))))))