(define/contract (maximum-set-size nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([s1 (list->set nums1)]
         [s2 (list->set nums2)]
         [common (set-count (set-intersect s1 s2))]
         [n (quotient (length nums1) 2)]
         [unique1 (set-count (set-subtract s1 s2))]
         [unique2 (set-count (set-subtract s2 s1))])
    (min (+ unique1 unique2 common) 
         (+ (min unique1 n) (min unique2 n) common))))