(define (xor-sum-of-all-pairs-bitwise-and nums1 nums2)
  (let* ((xor-sum1 (foldl bitwise-xor 0 nums1))
         (xor-sum2 (foldl bitwise-xor 0 nums2)))
    (bitwise-and xor-sum1 xor-sum2)))