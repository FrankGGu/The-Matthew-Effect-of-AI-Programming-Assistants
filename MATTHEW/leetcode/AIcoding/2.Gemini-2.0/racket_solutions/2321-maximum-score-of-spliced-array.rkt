(define (maximum-score-of-spliced-array nums1 nums2)
  (define (kadane arr)
    (define (helper arr current-max max-so-far)
      (cond
        [(empty? arr) max-so-far]
        [else
         (let* [(new-current-max (max 0 (+ current-max (car arr))))
                (new-max-so-far (max max-so-far new-current-max))]
           (helper (cdr arr) new-current-max new-max-so-far))]))
    (helper arr 0 (car arr)))

  (define (array-sum arr)
    (foldl + 0 arr))

  (let* [(diff12 (map - nums2 nums1))
         (diff21 (map - nums1 nums2))
         (kadane12 (kadane diff12))
         (kadane21 (kadane diff21))
         (sum1 (array-sum nums1))
         (sum2 (array-sum nums2))
         (max1 (+ sum1 kadane12))
         (max2 (+ sum2 kadane21))]
    (max max1 max2)))