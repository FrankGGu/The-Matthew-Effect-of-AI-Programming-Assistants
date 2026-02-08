(define (can-partition-k-subsets nums k)
  (call/cc
   (lambda (return)
     (define n (length nums))

     ;; If k is 1, we can always partition the array into one subset (the array itself).
     (when (= k 1) (return #t))

     ;; Calculate total sum of numbers.
     (define total-sum (foldl + 0 nums))

     ;; If total sum is not divisible by k, it's impossible to form k equal sum subsets.
     (when (not (= (remainder total-sum k) 0)) (return #f))

     ;; Calculate the target sum for each subset.
     (define target-sum (/ total-sum k))

     ;; Sort numbers in descending order. This helps prune search branches faster.
     (define sorted-nums (sort nums >))

     ;; If any number is greater than the target sum, it's impossible.
     (when (ormap (lambda (x) (> x target-sum)) sorted-nums) (return #f))

     ;; `used` vector to keep track of which numbers have been used in a subset.
     (define used (make-vector n #f))

     ;; Helper function for backtracking.
     ;; `index`: The current index in `sorted-nums` from which to start searching for a number.
     ;; `current-sum`: The sum of the current subset being built.
     ;; `buckets-filled`: The number of subsets successfully formed so far.
     (define (helper index current-sum buckets-filled)
       (cond
         ;; Base case 1: All k buckets have been successfully filled.
         [(= buckets-filled k) #t]

         ;; Base case 2: The current bucket has reached its target sum.
         ;; Start building the next bucket.
         [(= current-sum target-sum)
          ;; Reset `index` to 0 to consider all unused numbers for the new subset.
          ;; Increment `buckets-filled`.
          (helper 0 0 (add1 buckets-filled))]

         ;; Recursive step: Try to add numbers to the current bucket.
         [else
          (let loop ([i index])
            (cond
              ;; If we have exhausted all numbers for the current path, no solution found.
              [(>= i n) #f]
              [else
               (define num (vector-ref sorted-nums i))
               (if (and (not (vector-ref used i))      ;; If number is not used
                        (<= (+ current-sum num) target-sum)) ;; And it fits in current bucket
                   (begin
                     (vector-set! used i #t) ; Mark number as used
                     (if (helper (add1 i) (+ current-sum num) buckets-filled)
                         #t ; If recursive call finds a solution, propagate true
                         (begin
                           (vector-set! used i #f) ; Backtrack: unmark number as used

                           ;; Optimization: If we are starting a new bucket (current-sum = 0)
                           ;; and trying `num` failed, then trying subsequent identical numbers
                           ;; as the first element of a new bucket will also fail.
                           ;; Skip these duplicates to avoid redundant computations.
                           (if (= current-sum 0)
                               (let skip-duplicates ([j (add1 i)])
                                 (if (and (< j n) (= (vector-ref sorted-nums j) num))
                                     (skip-duplicates (add1 j))
                                     (loop j))) ; Continue loop from `j` (first non-duplicate)
                               (loop (add1 i)))))) ; Continue loop from next index
                   ;; If current number cannot be used (already used or too large), try the next one.
                   (loop (add1 i)))))])))

     ;; Initial call to the helper function:
     ;; Start searching from index 0, with current sum 0, and 0 buckets filled.
     (helper 0 0 0))))