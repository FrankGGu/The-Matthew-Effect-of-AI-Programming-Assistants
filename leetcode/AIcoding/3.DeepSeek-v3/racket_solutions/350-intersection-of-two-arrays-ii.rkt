(define/contract (intersect nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let loop ((nums1 nums1) (nums2 nums2) (result '()))
    (cond
      [(or (null? nums1) (null? nums2)) (reverse result)]
      [(= (car nums1) (car nums2)) (loop (cdr nums1) (cdr nums2) (cons (car nums1) result))]
      [(< (car nums1) (car nums2)) (loop (cdr nums1) nums2 result)]
      [else (loop nums1 (cdr nums2) result)])))