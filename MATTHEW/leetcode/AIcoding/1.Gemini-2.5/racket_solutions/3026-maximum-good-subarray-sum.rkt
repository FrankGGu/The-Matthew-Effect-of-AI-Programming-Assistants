#lang racket

(define (maximum-good-subarray-sum nums k)
  (define n (vector-length nums))

  ; Calculate prefix sums
  ; P[i] stores the sum of nums[0...i-1]
  ; P[0] = 0
  (define prefix-sums (make-vector (+ n 1)))
  (vector-set! prefix-sums 0 0)
  (for ([i (in-range n)])
    (vector-set! prefix-sums (+ i 1)
                 (+ (vector-ref prefix-sums i) (vector-ref nums i))))

  ; Initialize max-good-sum to a very small number
  ; Max possible sum is 10^5 * 10^9 = 10^14
  ; Min possible sum is 10^5 * (-10^9) = -10^14
  ; Use a value smaller than any possible sum to ensure any valid sum replaces it.
  ; Using a list to hold a mutable value for `set!`
  (define max-good-sum (build-list 1 (lambda (x) (- (expt 10 15))))) 

  ; Hash table to store (value_of_nums_idx, min_prefix_sum_P[idx])
  ; P[idx] is the sum of nums[0...idx-1]
  (define val-to-min-prefix-sum (make-hash))

  (for ([j (in-range n)])
    (define current-num (vector-ref nums j))
    (define current-prefix-sum-val (vector-ref prefix-sums (+ j 1))) ; This is P[j+1]

    ; Handle the case where i = j. This is only possible if k = 0.
    ; The subarray is [nums[j]], and its sum is nums[j].
    (when (= k 0)
      (set! (car max-good-sum) (max (car max-good-sum) current-num)))

    ; Check for target1 = current-num - k
    ; This corresponds to finding nums[i] such that nums[i] = nums[j] - k
    (define target1 (- current-num k))
    (when (hash-has-key? val-to-min-prefix-sum target1)
      (define min-P-for-target1 (hash-ref val-to-min-prefix-sum target1))
      (set! (car max-good-sum) (max (car max-good-sum) (- current-prefix-sum-val min-P-for-target1))))

    ; Check for target2 = current-num + k
    ; This corresponds to finding nums[i] such that nums[i] = nums[j] + k
    (define target2 (+ current-num k))
    (when (hash-has-key? val-to-min-prefix-sum target2)
      (define min-P-for-target2 (hash-ref val-to-min-prefix-sum target2))
      (set! (car max-good-sum) (max (car max-good-sum) (- current-prefix-sum-val min-P-for-target2))))

    ; Update val-to-min-prefix-sum for current-num (nums[j])
    ; We store P[j] (sum of nums[0...j-1]) for nums[j].
    ; This P[j] will be used if nums[j] becomes nums[i] for a future j' > j.
    (define prefix-sum-before-current-num (vector-ref prefix-sums j))
    ; If current-num is already in the map, update with the minimum prefix sum seen so far for that value.
    ; Otherwise, add it with the current prefix sum.
    (define old-min-P (hash-ref val-to-min-prefix-sum current-num prefix-sum-before-current-num))
    (hash-set! val-to-min-prefix-sum current-num (min old-min-P prefix-sum-before-current-num)))

  ; The problem statement implies that at least one good subarray exists.
  ; If no good subarray is found, max-good-sum would still be the initial sentinel value.
  ; In such cases, the problem usually specifies a return value (e.g., 0 or -1).
  ; Without specific instructions, returning the calculated maximum (which could be the sentinel) is standard.
  (car max-good-sum))