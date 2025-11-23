(define (intersection nums1 nums2)
  (define set1 (set nums1))
  (define set2 (set nums2))
  (set->list (set-intersection set1 set2)))