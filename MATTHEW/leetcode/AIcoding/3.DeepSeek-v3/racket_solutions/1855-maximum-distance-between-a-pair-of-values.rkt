(define/contract (max-distance nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [j 0] [max-dist 0])
    (cond
      [(or (>= i (length nums1)) (>= j (length nums2))] max-dist)
      [(<= (list-ref nums1 i) (list-ref nums2 j))
       (loop i (+ j 1) (max max-dist (- j i)))]
      [else (loop (+ i 1) j max-dist)])))