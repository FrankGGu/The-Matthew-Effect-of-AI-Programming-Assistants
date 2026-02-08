(define/contract (find-difference nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) (listof (listof exact-integer?)))
  (list
    (remove-duplicates (filter (lambda (x) (not (member x nums2))) nums1))
    (remove-duplicates (filter (lambda (x) (not (member x nums1))) nums2)))))