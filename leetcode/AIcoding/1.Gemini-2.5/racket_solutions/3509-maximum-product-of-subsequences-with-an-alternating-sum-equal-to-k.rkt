#lang racket

(define (maximum-product-of-subsequences-with-an-alternating-sum-equal-to-k nums k)
  (define n (length nums))

  ; If nums is empty, no non-empty subsequence can be formed.
  ; Return -1 as per typical LeetCode interpretation for non-empty subsequences.
  (when (zero? n)
    (if (zero? k)
        ; If k is 0 and nums is empty, some problems allow product 1 for empty subsequence.
        ; But "Maximum Product of Subsequences" usually implies non-empty.
        ; Assuming non-empty, so no subsequence for k=0.
        -1
        -1))

  (define max-val (apply max 1 nums)) ; nums[i] >= 1

  ; Calculate a loose upper bound for the absolute value of any possible alternating sum.
  ; The maximum sum is achieved by taking all numbers and adding them (not alternating).
  ; The minimum sum is achieved by taking all numbers and subtracting them.
  ; For an alternating sum, the range is smaller, but `n * max-val` is a safe upper bound
  ; for the magnitude of any sum that can be formed.
  ; For N=1000, max_val=1000, this is 10^6.
  (define max-sum-bound (* n max-val))

  ; If k is outside the possible range of alternating sums, return -1.
  ; K is non-negative (0 to 10^9).
  (when (> k max-sum-bound)
    -1)

  ; Initialize dp-add and dp-sub as hash tables.
  ; dp-add[s] = maximum product for an alternating sum 's', where the last operation was addition.
  ; dp-sub[s] = maximum product for an alternating sum 's', where the last operation was subtraction.
  ; Products are always positive integers (nums[i] >= 1), so 0 means no path to this sum.
  (define dp-add (make-hash))
  (define dp-sub (make-hash))

  (for ([num (in-list nums)])
    ; Create copies of current DP states to iterate over.
    ; This ensures we only use states from *before* processing `num` for extensions.
    ; The dp-add/dp-sub tables are updated for `num`.
    (define current-dp-add (hash-copy dp-add))
    (define current-dp-sub (hash-copy dp-sub))

    ; Option 1: `num` starts a new subsequence.
    ; It's the first element, so it's added. Sum `num`, product `num`.
    ; This subsequence ends with an addition.
    (hash-set! dp-add num (max (hash-ref dp-add num 0) num))

    ; Option 2: `num` is subtracted from a subsequence that ended with an addition.
    ; (i.e., we are extending a state from `current-dp-add`)
    (hash-for-each
     current-dp-add
     (lambda (s prod)
       (define new-s (- s num))
       (define new-prod (* prod num))
       (hash-set! dp-sub new-s (max (hash-ref dp-sub new-s 0) new-prod))))

    ; Option 3: `num` is added to a subsequence that ended with a subtraction.
    ; (i.e., we are extending a state from `current-dp-sub`)
    (hash-for-each
     current-dp-sub
     (lambda (s prod)
       (define new-s (+ s num))
       (define new-prod (* prod num))
       (hash-set! dp-add new-s (max (hash-ref dp-add new-s 0) new-prod))))
    )

  (define result 0)
  ; Check both dp-add and dp-sub for the target sum k.
  (hash-for-each
   dp-add
   (lambda (s prod)
     (when (= s k)
       (set! result (max result prod)))))

  (hash-for-each
   dp-sub
   (lambda (s prod)
     (when (= s k)
       (set! result (max result prod)))))

  ; If result is still 0, it means no subsequence achieved sum K.
  (if (zero? result) -1 result))