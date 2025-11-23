(define/contract (num-subarray-product-less-than-k nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (if (<= k 1)
      0
      (let loop ([left 0] [right 0] [product 1] [result 0])
        (if (>= right (length nums))
            result
            (let* ([product (* product (list-ref nums right))]
                   [new-left (let adjust ([left left] [product product])
                              (if (>= product k)
                                  (adjust (+ left 1) (/ product (list-ref nums left)))
                                  left))])
              (loop new-left
                    (+ right 1)
                    (if (> product k)
                        (/ product (list-ref nums new-left))
                        product)
                    (+ result (- right new-left) 1)))))))