(define (reverse-subarray-to-maximize-array-value nums)
  (let* ([n (vector-length nums)]
         [initial-sum (let loop ([i 0] [s 0])
                        (if (>= i (- n 1))
                            s
                            (loop (+ i 1) (+ s (abs (- (vector-ref nums i) (vector-ref nums (+ i 1))))))))]
         [max-diff 0])

    ;; Handle cases where the reversed subarray includes an endpoint of the array.
    ;; This means either nums[0...k] is reversed, or nums[j...n-1] is reversed.
    ;; The loop variable 'i' here represents the index of the first element of an adjacent pair (nums[i], nums[i+1]).
    ;; For reversing nums[0...k], the affected pair is (nums[k], nums[k+1]). So 'i' in the loop is 'k'.
    ;; For reversing nums[j...n-1], the affected pair is (nums[j-1], nums[j]). So 'i' in the loop is 'j-1'.
    (for ([i (in-range (- n 1))])
      ;; Case: Reversing nums[0...i] (segment ends at index i, starts at 0)
      ;; The original connection is |nums[i] - nums[i+1]|.
      ;; After reversal, nums[i] moves to index 0, and nums[0] moves to index i.
      ;; The new connection is |nums[0] - nums[i+1]|.
      (set! max-diff (max max-diff (- (abs (- (vector-ref nums 0) (vector-ref nums (+ i 1))))
                                      (abs (- (vector-ref nums i) (vector-ref nums (+ i 1)))))))

      ;; Case: Reversing nums[i+1...n-1] (segment starts at index i+1, ends at n-1)
      ;; The original connection is |nums[i] - nums[i+1]|.
      ;; After reversal, nums[i+1] moves to index n-1, and nums[n-1] moves to index i+1.
      ;; The new connection is |nums[i] - nums[n-1]|.
      (set! max-diff (max max-diff (- (abs (- (vector-ref nums i) (vector-ref nums (- n 1))))
                                      (abs (- (vector-ref nums i) (vector-ref nums (+ i 1))))))))

    ;; Handle cases where the reversed subarray is strictly internal (0 < j <= k < n-1).
    ;; Let the original adjacent pairs be (a,b) and (c,d), where a=nums[j-1], b=nums[j], c=nums[k], d=nums[k+1].
    ;; After reversal, the new adjacent pairs are (a,c) and (b,d).
    ;; The change in value is (|a-c| + |b-d|) - (|a-b| + |c-d|).
    ;; This expression can be maximized by finding the maximum overlap between the intervals [min(x,y), max(x,y)]
    ;; for all adjacent pairs (x,y) in the original array.
    ;; The maximum gain from such an internal reversal is 2 * max(0, max_of_min_endpoints - min_of_max_endpoints).
    (let ([min-max-val (expt 10 9)] ; Stores the minimum of all max(nums[i], nums[i+1])
          [max-min-val (expt -10 9)]) ; Stores the maximum of all min(nums[i], nums[i+1])

      (for ([i (in-range (- n 1))])
        (let* ([val1 (vector-ref nums i)]
               [val2 (vector-ref nums (+ i 1))]
               [m (min val1 val2)] ; min endpoint of current interval
               [M (max val1 val2)]) ; max endpoint of current interval
          (set! min-max-val (min min-max-val M))
          (set! max-min-val (max max-min-val m))))

      (set! max-diff (max max-diff (* 2 (- max-min-val min-max-val)))))

    (+ initial-sum max-diff)))