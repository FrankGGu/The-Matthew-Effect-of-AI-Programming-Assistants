(define/contract (min-number nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([common (sort (set-intersect (list->set nums1) (list->set nums2)) <)]
         [min1 (apply min nums1)]
         [min2 (apply min nums2)])
    (cond
      [(not (empty? common)) (first common)]
      [else (let ([a (min min1 min2)]
                  [b (max min1 min2)])
              (+ (* a 10) b))])))