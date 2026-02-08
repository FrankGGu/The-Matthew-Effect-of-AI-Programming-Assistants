(define (search nums target)
  (define (search-helper low high)
    (cond
      ((> low high) #f) ; Base case: search range is empty
      (else
       (let* ((mid (+ low (quotient (- high low) 2)))
              (mid-val (list-ref nums mid))
              (low-val (list-ref nums low))
              (high-val (list-ref nums high)))
         (cond
           ((= mid-val target) #t) ; Target found

           ;; Handle duplicates: If nums[low], nums[mid], and nums[high] are all the same,
           ;; we cannot determine which half is sorted. Shrink the search space from both ends.
           ((and (= low-val mid-val) (= mid-val high-val))
            (search-helper (+ low 1) (- high 1)))

           ;; Left half is sorted (nums[low] <= nums[mid])
           ((<= low-val mid-val)
            (if (and (>= target low-val)
                     (< target mid-val))
                (search-helper low (- mid 1)) ; Target is in the left sorted part
                (search-helper (+ mid 1) high))) ; Target is in the right part (might be rotated)

           ;; Right half is sorted (nums[low] > nums[mid], meaning rotation point is in the left part)
           (else ; (> low-val mid-val)
            (if (and (> target mid-val)
                     (<= target high-val))
                (search-helper (+ mid 1) high) ; Target is in the right sorted part
                (search-helper low (- mid 1)))))))) ; Target is in the left part (might be rotated)

  (search-helper 0 (- (length nums) 1)))