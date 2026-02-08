(define (find-median-sorted-arrays nums1 nums2)
  (let* ([merged (sort (append nums1 nums2) <)]
         [len (length merged)]
         [mid (quotient len 2)])
    (if (odd? len)
        (list-ref merged mid)
        (/ (+ (list-ref merged mid) (list-ref merged (- mid 1))) 2))))