(define (can-split nums m)
  (define n (vector-length nums))

  ;; Base case: if n is 1, the array is already split into length 1.
  (when (= n 1)
    (true))

  ;; dp[i][j] will be true if the subarray nums[i...j] can be fully split into length-1 subarrays.
  (define dp (make-vector n (make-vector n #f)))

  ;; Initialize dp[i][i] to true, as single elements are already considered split.
  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i #t))

  ;; Calculate prefix sums for O(1) sum queries.
  ;; prefix-sums[k] stores the sum of nums[0...k-1].
  (define prefix-sums (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref nums i))))

  ;; Helper function to get the sum of elements in nums from index 'start' to 'end' (inclusive).
  (define (get-sum start end)
    (- (vector-ref prefix-sums (+ end 1)) (vector-ref prefix-sums start)))

  ;; Fill the DP table. 'len' represents the current subarray length.
  (for ([len (in-range 2 (+ n 1))]) ; len goes from 2 to n
    ;; 'i' is the starting index of the current subarray.
    (for ([i (in-range (- n len) (+ 1))]) ; i goes from 0 to n - len
      (define j (+ i len -1)) ; 'j' is the ending index of the current subarray.

      ;; Try all possible split points 'k' within the current subarray [i...j].
      ;; A split at 'k' divides the subarray into [i...k] and [k+1...j].
      (for ([k (in-range i j)]) ; k goes from i to j-1
        ;; Check if the sum of the first part of the split (nums[i...k]) meets the requirement 'm'.
        (when (>= (get-sum i k) m)
          ;; If it meets the requirement, then check if both resulting subarrays
          ;; (nums[i...k] and nums[k+1...j]) can themselves be fully split.
          (when (and (vector-ref (vector-ref dp i) k)
                     (vector-ref (vector-ref dp (+ k 1)) j))
            ;; If both conditions are met, then nums[i...j] can be fully split.
            (vector-set! (vector-ref dp i) j #t)
            ;; Optimization: Once dp[i][j] is true, no need to check other 'k' values for this (i, j).
            ;; We can exit this inner loop, but for N=100, letting it continue is acceptable.
            ))))

  ;; The result is whether the entire array nums[0...n-1] can be split.
  (vector-ref (vector-ref dp 0) (- n 1)))