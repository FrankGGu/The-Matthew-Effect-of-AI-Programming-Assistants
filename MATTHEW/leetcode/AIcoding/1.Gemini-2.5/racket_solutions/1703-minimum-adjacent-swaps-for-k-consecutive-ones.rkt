(define (min-adjacent-swaps-k-consecutive-ones nums k)
  ;; 1. Find all indices of '1's in nums.
  (let* ([ones-indices (for/list ([val (in-list nums)]
                                  [idx (in-naturals)]
                                  #:when (= val 1))
                         idx)]
         [m (length ones-indices)])

    ;; Problem constraints state 1 <= k <= sum(nums), so m >= k.
    ;; If m < k, it's impossible to get k consecutive ones, but this case should not happen based on constraints.
    (when (< m k)
      (error "Not enough ones to form k consecutive ones"))

    ;; 2. Create a new list A where A[j] = pos[j] - j.
    ;;    Convert to vector for O(1) access.
    ;;    The sequence A is guaranteed to be non-decreasing:
    ;;    (pos[j+1] - (j+1)) - (pos[j] - j) = pos[j+1] - pos[j] - 1.
    ;;    Since pos[j+1] >= pos[j] + 1 (as indices of distinct ones),
    ;;    pos[j+1] - pos[j] - 1 >= 0.
    (let* ([a-values (for/list ([pos-val (in-list ones-indices)]
                                 [j (in-naturals)])
                       (- pos-val j))]
           [a-vec (list->vector a-values)])

      ;; 3. Compute prefix sums for A.
      ;;    prefix-sum-a-vec[x] stores the sum of A[0]...A[x-1].
      ;;    So prefix-sum-a-vec has length m+1, with prefix-sum-a-vec[0] = 0.
      (let* ([prefix-sum-a-vec (make-vector (+ m 1) 0)]
             [_ (for ([j (in-range m)])
                  (vector-set! prefix-sum-a-vec (+ j 1)
                               (+ (vector-ref prefix-sum-a-vec j)
                                  (vector-ref a-vec j))))]
             [min-cost +inf.0]
             ;; m-offset is the index of the median element within a window of size k
             ;; e.g., for k=3, median is at index 1 (0-indexed). floor((3-1)/2) = 1.
             ;; for k=2, median is at index 0. floor((2-1)/2) = 0.
             [m-offset (floor (/ (- k 1) 2))])

        ;; 4. Iterate i from 0 to m-k (inclusive).
        ;;    This represents the starting index of the window of k ones in ones-indices.
        (for ([i (in-range (- m k -1))])
          (let* ([median-idx (+ i m-offset)] ; Index of the median element in a-vec
                 [median-val (vector-ref a-vec median-idx)]

                 ;; Calculate sum of elements to the left of median (inclusive)
                 ;; These are A[i], ..., A[median-idx]
                 [sum-left-elements (- (vector-ref prefix-sum-a-vec (+ median-idx 1))
                                       (vector-ref prefix-sum-a-vec i))]
                 [count-left (+ m-offset 1)]

                 ;; Calculate sum of elements to the right of median (exclusive)
                 ;; These are A[median-idx+1], ..., A[i+k-1]
                 [sum-right-elements (- (vector-ref prefix-sum-a-vec (+ i k))
                                        (vector-ref prefix-sum-a-vec (+ median-idx 1)))]
                 [count-right (- k count-left)]

                 ;; Calculate current cost for this window
                 ;; Cost = sum(|val_j - median_val|)
                 ;;      = (sum of (median_val - val_j) for val_j <= median_val)
                 ;;        + (sum of (val_j - median_val) for val_j > median_val)
                 ;;      = (count_left * median_val - sum_left_elements)
                 ;;        + (sum_right_elements - count_right * median_val)
                 [current-cost (+ (- (* count-left median-val) sum-left-elements)
                                  (- sum-right-elements (* count-right median-val)))])
            (set! min-cost (min min-cost current-cost))))

        min-cost))))