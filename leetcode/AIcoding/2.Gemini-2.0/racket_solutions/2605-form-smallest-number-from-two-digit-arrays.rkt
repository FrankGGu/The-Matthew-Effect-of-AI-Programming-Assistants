(define (min-number nums1 nums2)
  (let* ((common (intersect nums1 nums2))
         (min-common (if (empty? common) #f (apply min common))))
    (if min-common
        min-common
        (let* ((min1 (apply min nums1))
               (min2 (apply min nums2)))
          (min (string->number (string-append (number->string min1) (number->string min2)))
               (string->number (string-append (number->string min2) (number->string min1))))))))