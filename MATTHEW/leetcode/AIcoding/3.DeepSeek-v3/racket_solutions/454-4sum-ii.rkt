(define/contract (four-sum-count nums1 nums2 nums3 nums4)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([n (length nums1)]
         [sum-count (make-hash)])
    (for* ([i (in-range n)]
           [j (in-range n)])
      (let ([sum (+ (list-ref nums1 i) (list-ref nums2 j))])
        (hash-update! sum-count sum add1 0)))
    (let ([count 0])
      (for* ([k (in-range n)]
             [l (in-range n)])
        (let ([sum (+ (list-ref nums3 k) (list-ref nums4 l))])
          (set! count (+ count (hash-ref sum-count (- 0 sum) 0))))
      count)))