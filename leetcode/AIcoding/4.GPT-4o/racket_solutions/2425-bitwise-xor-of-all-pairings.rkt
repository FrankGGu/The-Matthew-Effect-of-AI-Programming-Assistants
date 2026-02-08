(define (xorAllNums nums1 nums2)
  (define (xor-list lst)
    (foldl (lambda (x acc) (bitwise-xor x acc)) 0 lst))
  (if (or (null? nums1) (null? nums2))
      0
      (bitwise-xor (xor-list nums1) (xor-list nums2))))