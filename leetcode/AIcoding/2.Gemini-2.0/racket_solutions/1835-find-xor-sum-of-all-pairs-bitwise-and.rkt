(define (get-xor-sum arr1 arr2)
  (let ((xor1 (foldl xor 0 arr1))
        (xor2 (foldl xor 0 arr2)))
    (bitwise-and xor1 xor2)))