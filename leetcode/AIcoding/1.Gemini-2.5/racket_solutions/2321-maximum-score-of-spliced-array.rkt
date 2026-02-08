(define (maximum-score-of-spliced-array nums1 nums2)
  (define (kadane arr)
    (let loop ((current-max 0)
               (max-so-far 0)
               (lst arr))
      (if (empty? lst)
          max-so-far
          (let* ((x (car lst))
                 (new-current-max (+ current-max x))
                 (reset-current-max (max 0 new-current-max)))
            (loop reset-current-max
                  (max max-so-far reset-current-max)
                  (cdr lst))))))

  (let* ((sum1 (apply + nums1))
         (sum2 (apply + nums2))

         (diff1 (for/list ((x nums1) (y nums2)) (- y x)))
         (diff2 (for/list ((x nums1) (y nums2)) (- x y)))

         (max-kadane-diff1 (kadane diff1))
         (max-kadane-diff2 (kadane diff2)))

    (max (+ sum1 max-kadane-diff1)
         (+ sum2 max-kadane-diff2))))