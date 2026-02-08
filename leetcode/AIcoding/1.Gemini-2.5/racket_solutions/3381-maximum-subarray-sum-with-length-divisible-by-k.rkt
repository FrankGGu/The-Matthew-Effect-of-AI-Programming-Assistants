(define (max-subarray-sum-with-length-divisible-by-k nums k)
  (define n (length nums))

  ;; Initialize prefix-sums vector
  ;; prefix-sums[i] = sum of nums[0...i-1]
  ;; prefix-sums has n+1 elements
  (define prefix-sums (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix-sums (+ i 1)
                 (+ (vector-ref prefix-sums i) (list-ref nums i))))

  ;; Define sufficiently large/small numbers for initialization
  ;; Max possible sum is N * 10^9 = 10^5 * 10^9 = 10^14.
  ;; Min possible sum is N * -10^9 = -10^14.
  ;; Use 10^15 as a safe bound for Racket's arbitrary precision integers.
  (define +inf (expt 10 15)) 
  (define -inf (- +inf))    

  ;; Initialize min-prefix-sum-by-rem vector
  ;; Stores the minimum prefix-sums[idx] for each (modulo idx k)
  ;; min-prefix-sum-by-rem[0] is initialized with prefix-sums[0] (which is 0)
  (define min-prefix-sum-by-rem (make-vector k +inf))
  (vector-set! min-prefix-sum-by-rem 0 0) ; P[0] = 0, and (modulo 0 k) = 0

  (define max-sum -inf)

  ;; Iterate through prefix-sums from index 1 to n (inclusive)
  ;; This ensures that we are always considering non-empty subarrays,
  ;; as current-prefix-sum (P[j]) will always be for j > 0,
  ;; and min-val-for-rem (P[i]) will always be for i < j.
  (for ([j (in-range 1 (+ n 1))])
    (define current-prefix-sum (vector-ref prefix-sums j))
    (define current-index-rem (modulo j k))

    (define min-val-for-rem (vector-ref min-prefix-sum-by-rem current-index-rem))

    ;; If a prefix sum for this remainder has been seen before (i.e., not +inf)
    ;; then we have a candidate subarray sum.
    (when (!= min-val-for-rem +inf)
      (set! max-sum (max max-sum (- current-prefix-sum min-val-for-rem))))

    ;; Update min-prefix-sum-by-rem for the current remainder
    ;; We only want to store the *minimum* prefix sum for each remainder.
    (vector-set! min-prefix-sum-by-rem current-index-rem
                 (min min-val-for-rem current-prefix-sum)))

  max-sum)