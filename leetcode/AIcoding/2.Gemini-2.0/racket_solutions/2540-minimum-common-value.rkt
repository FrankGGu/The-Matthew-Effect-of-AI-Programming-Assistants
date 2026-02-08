(define (get-common (nums1 nums2))
  (let loop ([i 0] [j 0])
    (cond
      [(or (= i (length nums1)) (= j (length nums2))) -1]
      [(= (list-ref nums1 i) (list-ref nums2 j)) (list-ref nums1 i)]
      [(< (list-ref nums1 i) (list-ref nums2 j)) (loop (+ i 1) j)]
      [else (loop i (+ j 1))])))