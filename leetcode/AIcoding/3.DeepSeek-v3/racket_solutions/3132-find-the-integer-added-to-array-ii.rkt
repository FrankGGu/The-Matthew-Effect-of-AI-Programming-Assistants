(define (added-integer nums1 nums2)
  (let* ([sorted1 (sort nums1 <)]
         [sorted2 (sort nums2 <)]
         [diff1 (- (first sorted2) (first sorted1))]
         [diff2 (- (second sorted2) (second sorted1))]
         [diff3 (- (third sorted2) (third sorted1))])
    (cond
      [(= diff1 diff2 diff3) diff1]
      [(= diff1 diff2) diff1]
      [(= diff1 diff3) diff1]
      [else diff2])))