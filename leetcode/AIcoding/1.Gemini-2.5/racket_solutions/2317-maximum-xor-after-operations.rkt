(define (maximum-xor-after-operations nums)
  (let* ((n (length nums))
         (or-sum (foldl bitwise-ior 0 nums))
         (and-sum (foldl bitwise-and -1 nums))) ; -1 is a mask with all bits set, serving as identity for bitwise-and
    (if (odd? n)
        or-sum
        (bitwise-xor or-sum and-sum))))