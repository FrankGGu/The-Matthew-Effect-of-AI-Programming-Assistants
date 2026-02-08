(define (xor-all-pairings nums1 nums2)
  (let* ((n (length nums1))
         (m (length nums2))
         (xor-a (foldl bitwise-xor 0 nums1))
         (xor-b (foldl bitwise-xor 0 nums2)))
    (cond
      ((= (modulo n 2) 0) ; n is even
       (if (= (modulo m 2) 0) ; m is even
           0
           xor-a)) ; m is odd
      (else ; n is odd
       (if (= (modulo m 2) 0) ; m is even
           xor-b
           (bitwise-xor xor-a xor-b)))))) ; m is odd