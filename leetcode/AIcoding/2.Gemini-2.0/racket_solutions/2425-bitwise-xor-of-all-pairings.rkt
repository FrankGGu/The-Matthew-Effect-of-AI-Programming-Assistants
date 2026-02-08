(define (xor-all-pairings nums1 nums2)
  (let* ((xor1 (foldl (lambda (x acc) (bitwise-xor x acc)) 0 nums1))
         (xor2 (foldl (lambda (x acc) (bitwise-xor x acc)) 0 nums2)))
    (if (and (even? (length nums1)) (even? (length nums2)))
        0
        (if (even? (length nums1))
            xor1
            (if (even? (length nums2))
                xor2
                (bitwise-xor xor1 xor2))))))