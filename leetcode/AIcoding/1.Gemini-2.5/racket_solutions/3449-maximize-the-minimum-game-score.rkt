(define (maximize-the-minimum-game-score nums k)
  ;; Helper function to check if it's possible to partition nums into at least k subarrays
  ;; such that each subarray's sum is at least 'target'.
  (define (check target)
    (let loop ((idx 0)
               (current-sum 0)
               (partitions 0))
      (cond
        ((>= partitions k) #t) ; Already formed k partitions
        ((= idx (length nums)) ; Reached end of array
         (if (>= current-sum target) ; Check if the last partition meets target
             (>= (+ partitions 1) k)
             (>= partitions k))) ; If last partition doesn't meet target, check if previous ones were enough
        (else
         (let* ((num (list-ref nums idx))
                (new-sum (+ current-sum num)))
           (if (>= new-sum target)
               ;; Start a new partition
               (loop (+ idx 1) 0 (+ partitions 1))
               ;; Continue current partition
               (loop (+ idx 1) new-sum partitions)))))))

  ;; Handle empty nums or k=0 if necessary, though LeetCode constraints usually prevent this.
  (when (or (null? nums) (= k 0))
    (error "Invalid input: nums cannot be empty and k must be positive."))

  ;; Calculate the search range for the binary search
  (let* ((total-sum (apply + nums))
         (min-val (if (null? nums) 0 (apply min nums))) ; Smallest possible sum for a single element partition
         (low min-val)
         (high total-sum)
         (ans 0))

    ;; Binary search for the maximum possible minimum score
    (let loop ((l low) (h high) (result ans))
      (if (> l h)
          result
          (let* ((mid (+ l (quotient (- h l) 2))))
            (if (check mid)
                ;; If 'mid' is achievable, try for a higher score
                (loop (+ mid 1) h mid)
                ;; If 'mid' is not achievable, try for a lower score
                (loop l (- mid 1) result)))))))