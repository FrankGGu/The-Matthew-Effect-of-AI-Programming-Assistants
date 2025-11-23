(define/contract (two-out-of-three nums1 nums2 nums3)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let* ([s1 (list->set nums1)]
         [s2 (list->set nums2)]
         [s3 (list->set nums3)]
    (set->list (set-union (set-intersect s1 s2)
                          (set-intersect s1 s3)
                          (set-intersect s2 s3)))))