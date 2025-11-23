(define (max-distance nums1 nums2)
  (let loop ([i 0] [j 0] [max-dist 0])
    (cond
      [(>= i (length nums1)) max-dist]
      [(>= j (length nums2)) max-dist]
      [(>= i (length nums1)) max-dist]
      [else
       (cond
         [(= (list-ref nums1 i) (list-ref nums2 j))
          (loop (add1 i) (add1 j) (max max-dist (- j i)))]
         [(> (list-ref nums1 i) (list-ref nums2 j))
          (loop (add1 i) j max-dist)]
         [else
          (loop i (add1 j) max-dist)])])))