(define (get-common nums1 nums2)
  (cond
    [(or (empty? nums1) (empty? nums2)) -1]
    [(< (car nums1) (car nums2)) (get-common (cdr nums1) nums2)]
    [(< (car nums2) (car nums1)) (get-common nums1 (cdr nums2))]
    [else (car nums1)]))