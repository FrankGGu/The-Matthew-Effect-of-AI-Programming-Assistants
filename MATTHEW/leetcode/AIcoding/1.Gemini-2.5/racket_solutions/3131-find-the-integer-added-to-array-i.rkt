(define (find-the-integer-added-to-array-i nums1 nums2)
  (let* ((sorted-nums1 (sort nums1 <))
         (sorted-nums2 (sort nums2 <)))
    (- (car sorted-nums2) (car sorted-nums1))))