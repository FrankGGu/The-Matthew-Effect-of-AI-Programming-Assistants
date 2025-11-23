(define (form-smallest-number-from-two-digit-arrays nums1 nums2)
  (let* ((min1 (apply min nums1))
         (min2 (apply min nums2))
         (common-elements (filter (lambda (x) (member x nums2)) nums1))
         (min-common (if (empty? common-elements)
                         +inf.0
                         (apply min common-elements))))
    (min min-common
         (+ (* 10 (min min1 min2)) (max min1 min2)))))