(define (get-xor-sum arr1 arr2)
  (define (xor-sum arr)
    (foldl bitwise-xor 0 arr))
  (bitwise-and (xor-sum arr1) (xor-sum arr2)))