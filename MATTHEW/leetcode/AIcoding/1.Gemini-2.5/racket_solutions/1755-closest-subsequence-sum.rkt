(define (closest-subsequence-sum nums goal)
  (define n (length nums))
  (define mid (quotient n 2))

  (define nums1 (take nums mid))
  (define nums2 (drop nums mid))

  ;; Function to generate all possible subsequence sums for a given list of numbers.
  ;; It uses a foldl operation:
  ;; - Starts with a list containing only 0 (representing the empty subsequence sum).
  ;; - For each number in the input list, it generates a new set of sums by adding
  ;;   the current number to all previously generated sums.
  ;; - These new sums are appended to the existing sums to form the updated list of sums.
  (define (generate-all-sums arr)
    (foldl (lambda (num current-sums)
             (append current-sums (map (lambda (s) (+ s num)) current-sums)))
           (list 0)
           arr))

  ;; Generate all sums for the first half of the numbers.
  (define sums1 (generate-all-sums nums1))
  ;; Generate all sums for the second half of the numbers.
  (define sums2 (generate-all-sums nums2))

  ;; Sort sums2 and convert it to a vector for efficient binary search (O(1) access).
  (define sums2-vec (list->vector (sort sums2 <)))
  (define sums2-vec-len (vector-length sums2-vec))

  ;; Binary search function to find the index of the first element in a sorted vector
  ;; that is greater than or equal to the target value.
  ;; If no such element exists, it returns sums2-vec-len.
  (define (lower-bound vec target)
    (let loop ((low 0) (high sums2-vec-len) (ans sums2-vec-len))
      (if (= low high)
          ans
          (let ((mid (quotient (+ low high) 2)))
            (if (>= (vector-ref vec mid) target)
                (loop low mid mid)
                (loop (+ mid 1) high ans))))))

  ;; Initialize the minimum absolute difference.
  ;; Since an empty subsequence sum (0) is always possible, `(abs goal)` is an initial candidate.
  (define min-abs-diff (abs goal))

  ;; Iterate through each sum `s1` generated from the first half.
  (for-each (lambda (s1)
              ;; For a given `s1`, we need to find `s2` from `sums2` such that `s1 + s2` is
              ;; as close to `goal` as possible. This means `s2` should be close to `goal - s1`.
              (let* ((target-s2 (- goal s1))
                     ;; Find the index of the first element in `sums2-vec` that is >= `target-s2`.
                     (idx (lower-bound sums2-vec target-s2)))

                ;; Check the element at `idx` (if it's a valid index).
                ;; This element is `s2_ge` (greater than or equal to target-s2).
                (when (< idx sums2-vec-len)
                  (set! min-abs-diff (min min-abs-diff (abs (- (+ s1 (vector-ref sums2-vec idx)) goal)))))

                ;; Check the element just before `idx` (if `idx` is not 0).
                ;; This element is `s2_lt` (less than target-s2).
                (when (> idx 0)
                  (set! min-abs-diff (min min-abs-diff (abs (- (+ s1 (vector-ref sums2-vec (- idx 1))) goal)))))))
            sums1)

  ;; Return the minimum absolute difference found.
  min-abs-diff)