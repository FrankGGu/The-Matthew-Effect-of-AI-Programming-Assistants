(define (number-of-pairs nums1 nums2 diff)
  (let loop ((i 0) (j 0) (count 0))
  (if (>= i (length nums1))
      count
      (if (>= j (length nums2))
          (loop (+ i 1) 0 count)
          (if (<= (- (list-ref nums1 i) (list-ref nums2 j)) diff)
              (loop i (+ j 1) (+ count 1))
              (loop i (+ j 1) count)))))