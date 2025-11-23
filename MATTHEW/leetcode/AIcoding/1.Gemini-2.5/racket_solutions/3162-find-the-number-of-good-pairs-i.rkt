(define (good-pairs nums1 nums2 k)
  (let ([n (length nums1)])
    (for/sum ([i (range n)])
      (for/sum ([j (range n)])
        (if (= (list-ref nums1 i) (* (list-ref nums2 j) k))
            1
            0)))))