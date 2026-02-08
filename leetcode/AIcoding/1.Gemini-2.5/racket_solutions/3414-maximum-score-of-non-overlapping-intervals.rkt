(define (max-score-non-overlapping-intervals intervals)
  ;; 1. Sort intervals by their end times.
  ;; If end times are equal, the order doesn't strictly matter for correctness
  ;; in this DP approach, but a consistent sort is good practice.
  (define sorted-intervals-list
    (sort intervals (lambda (a b) (< (cadr a) (cadr b)))))

  (define n (length sorted-intervals-list))

  ;; Convert the sorted list of intervals to a vector for O(1) access
  ;; during the binary search in `find-prev-dp-value`.
  (define sorted-intervals (list->vector sorted-intervals-list))

  ;; `dp` vector: `dp[i]` will store the maximum score considering the first `i` intervals
  ;; from the `sorted-intervals` vector (0-indexed).
  ;; `dp` is 1-indexed for interval count, so `dp[0]` is for 0 intervals,
  ;; `dp[1]` for the 1st interval, etc.
  (define dp (make-vector (add1 n) 0))

  ;; Helper function to find the maximum score from non-overlapping intervals
  ;; that end before `current-start-time`.
  ;; It performs a binary search on `sorted-intervals` (from index 0 up to `current-interval-idx - 1`)
  ;; to find the largest index `k` such that `(interval-end (vector-ref sorted-intervals k))`
  ;; is less than or equal to `current-start-time`.
  ;; It then returns `dp[k+1]` (since `dp` is 1-indexed for interval count).
  ;; If no such interval is found, it returns 0.
  (define (find-prev-dp-value current-start-time current-interval-idx)
    (let loop ((low 0) (high (sub1 current-interval-idx)) (best-idx -1))
      (if (> low high)
          ;; Binary search finished.
          (if (= best-idx -1)
              ;; No non-overlapping interval found.
              0
              ;; Return the DP value corresponding to the best non-overlapping interval found.
              (vector-ref dp (add1 best-idx)))
          (let* ((mid (quotient (+ low high) 2))
                 (interval-at-mid (vector-ref sorted-intervals mid))
                 (mid-end (cadr interval-at-mid)))
            (if (<= mid-end current-start-time)
                ;; This interval `mid` does not overlap.
                ;; Try to find an even later non-overlapping interval.
                (loop (add1 mid) high mid)
                ;; This interval `mid` overlaps. Search in the earlier half.
                (loop low (sub1 mid) best-idx))))))

  ;; Iterate through each interval in the sorted list.
  (for ([i (range n)])
    (let* ((current-interval (vector-ref sorted-intervals i))
           (s (car current-interval))   ;; Start time
           (e (cadr current-interval))  ;; End time
           (sc (caddr current-interval))) ;; Score

      ;; Option 1: Do not include the current interval.
      ;; The maximum score is the same as considering intervals up to `i-1`.
      (define option1 (vector-ref dp i))

      ;; Option 2: Include the current interval.
      ;; Find the maximum score from non-overlapping intervals that end before `s`.
      (define prev-score-for-option2 (find-prev-dp-value s i))
      (define option2 (+ sc prev-score-for-option2))

      ;; Update `dp[i+1]` with the maximum of the two options.
      ;; `dp[i+1]` corresponds to the maximum score considering the first `i+1` intervals.
      (vector-set! dp (add1 i) (max option1 option2))))

  ;; The final answer is the maximum score considering all `n` intervals.
  (vector-ref dp n))