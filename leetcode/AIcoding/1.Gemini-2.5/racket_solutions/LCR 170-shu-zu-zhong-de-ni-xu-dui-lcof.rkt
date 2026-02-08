(define (reverse-pairs nums)
  (define n (vector-length nums))
  (define temp (make-vector n 0)) ; Temporary vector for merging

  (define (merge-sort-and-count start end)
    (if (>= start end)
        0 ; Base case: single element or empty, no reverse pairs
        (let* ((mid (floor (/ (+ start end) 2)))
               (count ( + (merge-sort-and-count start mid)
                           (merge-sort-and-count (+ mid 1) end))))

          ; --- Counting reverse pairs (i in left, j in right) ---
          ; Both left (nums[start...mid]) and right (nums[(mid+1)...end]) sub-arrays are sorted at this point.
          (let ((j-ptr (+ mid 1))) ; Pointer for the right sub-array
            (for ((i-ptr (in-range start (+ mid 1)))) ; Iterate through the left sub-array from start to mid
                 (begin
                   ; Advance j-ptr as long as the condition holds
                   (while (and (<= j-ptr end)
                               (> (vector-ref nums i-ptr) (* 2 (vector-ref nums j-ptr))))
                     (set! j-ptr (+ j-ptr 1)))
                   ; All elements from (+ mid 1) to (j-ptr - 1) satisfy the condition for nums[i-ptr]
                   ; The number of such elements is (j-ptr - (+ mid 1))
                   (set! count (+ count (- j-ptr (+ mid 1)))))))

          ; --- Merging the two sorted halves ---
          ; Copy the current segment of 'nums' to 'temp'
          (for ((i (in-range start (+ end 1)))) ; Iterate from start to end
               (vector-set! temp i (vector-ref nums i)))

          (let ((p1 start) (p2 (+ mid 1)) (k start)) ; p1 for left half of temp, p2 for right half of temp, k for nums
            (while (and (<= p1 mid) (<= p2 end))
              (if (<= (vector-ref temp p1) (vector-ref temp p2))
                  (begin (vector-set! nums k (vector-ref temp p1)) (set! p1 (+ p1 1)))
                  (begin (vector-set! nums k (vector-ref temp p2)) (set! p2 (+ p2 1))))
              (set! k (+ k 1)))

            ; Copy any remaining elements from the left sub-array (if p2 exhausted first)
            (while (<= p1 mid)
              (vector-set! nums k (vector-ref temp p1))
              (set! p1 (+ p1 1))
              (set! k (+ k 1)))

            ; Copy any remaining elements from the right sub-array (if p1 exhausted first)
            (while (<= p2 end)
              (vector-set! nums k (vector-ref temp p2))
              (set! p2 (+ p2 1))
              (set! k (+ k 1))))

          count)))) ; Return the total count

  (merge-sort-and-count 0 (- n 1)))