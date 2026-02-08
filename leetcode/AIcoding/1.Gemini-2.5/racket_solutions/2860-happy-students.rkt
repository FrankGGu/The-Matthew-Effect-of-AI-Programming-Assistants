(define (happy-students nums)
  (let* ((n (length nums))
         (s-nums (sort nums <)) ; Sort the list in non-decreasing order
         (count 0))

    ;; Check the case where k = 0 students are selected.
    ;; All n students are unselected and must be unhappy.
    ;; This means nums[i] > 0 for all i.
    ;; In the sorted list, this is equivalent to s-nums[0] > 0.
    (when (> (list-ref s-nums 0) 0)
      (set! count (+ count 1)))

    ;; Check cases where k students are selected, for 1 <= k < n.
    ;; For a given k, we select the k students with the smallest nums[i] values.
    ;; These are s-nums[0] through s-nums[k-1].
    ;; Conditions for this k to be valid:
    ;; 1. All selected students must be happy: s-nums[k-1] <= k
    ;; 2. All unselected students must be unhappy: s-nums[k] > k
    (for ([k (in-range 1 n)]) ; k iterates from 1 to n-1
      (when (and (<= (list-ref s-nums (- k 1)) k)
                 (> (list-ref s-nums k) k))
        (set! count (+ count 1))))

    ;; Check the case where k = n students are selected.
    ;; All n students are selected and must be happy.
    ;; This means nums[i] <= n for all i.
    ;; In the sorted list, this is equivalent to s-nums[n-1] <= n.
    (when (<= (list-ref s-nums (- n 1)) n)
      (set! count (+ count 1)))

    count))