(define/contract (get-common nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [j 0])
    (cond
      [(or (>= i (length nums1)) (>= j (length nums2))) -1]
      [(= (list-ref nums1 i) (list-ref nums2 j)) (list-ref nums1 i)]
      [(< (list-ref nums1 i) (list-ref nums2 j)) (loop (add1 i) j)]
      [else (loop i (add1 j))])))