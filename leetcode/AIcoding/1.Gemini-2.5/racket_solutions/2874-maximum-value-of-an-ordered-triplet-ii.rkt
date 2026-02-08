#lang racket

(define (maximum-value-of-an-ordered-triplet-ii nums)
  (let* ([n (vector-length nums)])

    ;; If n < 3, no such triplet exists. The problem states to return 0
    ;; if all such triplets have a negative value, which implicitly covers this.
    ;; The loops below will not execute if n < 3, leaving max-val at 0.

    (define max-left (make-vector n 0))
    (define max-right (make-vector n 0))

    ;; Populate max-left: max-left[j] stores max(nums[0], ..., nums[j-1])
    ;; For j=0, there are no elements to the left, so 0 is a safe default
    ;; as nums[i] are non-negative.
    (when (> n 0)
      (vector-set! max-left 0 0)) ; Sentinel for index 0
    (for ([j (in-range 1 n)])
      (vector-set! max-left j (max (vector-ref max-left (- j 1)) (vector-ref nums (- j 1)))))

    ;; Populate max-right: max-right[j] stores max(nums[j+1], ..., nums[n-1])
    ;; For j=n-1, there are no elements to the right, so 0 is a safe default.
    (when (> n 0)
      (vector-set! max-right (- n 1) 0)) ; Sentinel for index n-1
    (for ([j (in-range (- n 2) -1 -1)]) ; Iterate from n-2 down to 0
      (vector-set! max-right j (max (vector-ref max-right (+ j 1)) (vector-ref nums (+ j 1)))))

    (define max-val 0)

    ;; Iterate j from 1 to n-2 (inclusive)
    ;; For each j, calculate (max_i - nums[j]) * max_k
    (for ([j (in-range 1 (- n 1))])
      (let* ([val-i (vector-ref max-left j)]
             [val-j (vector-ref nums j)]
             [val-k (vector-ref max-right j)])
        (set! max-val (max max-val (* (- val-i val-j) val-k)))))

    max-val))