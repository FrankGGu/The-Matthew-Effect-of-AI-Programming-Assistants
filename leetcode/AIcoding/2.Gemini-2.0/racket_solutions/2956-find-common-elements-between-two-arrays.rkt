(define (intersection nums1 nums2)
  (let ([set1 (list->set nums1)]
        [set2 (list->set nums2)])
    (list->set (filter (lambda (x) (set-member? set2 x)) (set->list set1)))))

(define (find-common-elements nums1 nums2)
  (list->vector (set->list (intersection nums1 nums2))))