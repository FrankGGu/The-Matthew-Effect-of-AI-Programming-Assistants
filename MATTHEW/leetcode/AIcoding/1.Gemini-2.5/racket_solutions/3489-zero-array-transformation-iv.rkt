#lang racket

(define (zero-array-transformation-iv nums)
  (define n (vector-length nums))
  (define ans 0)

  (for ([i (in-range n)])
    (define current-val (vector-ref nums i))

    (when (> current-val 0)
      ;; To make nums[i] zero, we must perform 'current-val' operations
      ;; that target index 'i'. Each such operation costs 1.
      ;; So, we add 'current-val' to the total answer.
      (set! ans (+ ans current-val))

      ;; Among these 'current-val' operations, we prioritize those that
      ;; also reduce nums[i+1] (type 2 operation). This is a greedy choice
      ;; because it helps reduce a future element's value without
      ;; increasing the current operation count for nums[i].
      ;; We can perform 'k' such operations, where 'k' is limited by
      ;; 'current-val' (the number of operations needed for nums[i])
      ;; and by 'nums[i+1]' (since we can't reduce it below zero).
      (when (< (+ i 1) n)
        (define next-val (vector-ref nums (+ i 1)))
        (when (> next-val 0)
          (define k (min current-val next-val))
          (vector-set! nums (+ i 1) (- next-val k))))

      ;; Note: Operations of type 3 (reducing nums[i] and nums[i-1]) are
      ;; implicitly handled. When processing nums[i] from left to right,
      ;; nums[i-1] would have already been reduced to zero (or its operations
      ;; accounted for). Thus, type 3 operations at index 'i' would effectively
      ;; be type 1 operations (as nums[i-1] is 0 and cannot be reduced further).
      ;; The current nums[i] is conceptually made zero by these operations,
      ;; so we don't need to explicitly set `(vector-set! nums i 0)`.
      ))
  ans)