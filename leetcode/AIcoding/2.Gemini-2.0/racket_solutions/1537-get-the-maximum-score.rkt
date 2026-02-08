(define (max-sum-after-merge nums1 nums2)
  (define MOD 1000000007)
  (define (solve nums1 nums2 i j sum1 sum2)
    (cond
      [(and (= i (length nums1)) (= j (length nums2)))
       (max sum1 sum2)]
      [(and (= i (length nums1)) (< j (length nums2)))
       (solve nums1 nums2 i (add1 j) sum1 (+ sum2 (list-ref nums2 j)))]
      [(and (< i (length nums1)) (= j (length nums2)))
       (solve nums1 nums2 (add1 i) j (+ sum1 (list-ref nums1 i)) sum2)]
      [else
       (cond
         [(= (list-ref nums1 i) (list-ref nums2 j))
          (max (solve nums1 nums2 (add1 i) j (+ (list-ref nums1 i) 0) (+ sum1 (list-ref nums1 i)))
               (solve nums1 nums2 i (add1 j) (+ (list-ref nums2 j) 0) (+ sum2 (list-ref nums2 j))))]
         [(< (list-ref nums1 i) (list-ref nums2 j))
          (solve nums1 nums2 (add1 i) j sum1 (+ sum1 (list-ref nums1 i)))]
         [else
          (solve nums1 nums2 i (add1 j) sum2 (+ sum2 (list-ref nums2 j)))])]))
  (modulo (solve nums1 nums2 0 0 0 0) MOD))