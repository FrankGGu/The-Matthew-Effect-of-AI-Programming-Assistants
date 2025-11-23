#lang racket

(define (longest-increasing-subsequence-ii nums k)
  (define MAX_NUM_VAL 100000) ; Maximum possible value for nums[i]

  ; Segment tree array. We use a size of 4 * (MAX_NUM_VAL + 1)
  ; to accommodate 1-based indexing up to MAX_NUM_VAL and for tree structure.
  (define tree (make-vector (* 4 (+ MAX_NUM_VAL 1)) 0))

  ; Segment tree update function
  ; Updates the value at index `idx` to `val`.
  ; For a max segment tree, we store the maximum of the current value and `val`
  ; at the leaf node, and propagate maximums upwards.
  (define (update node start end idx val)
    (when (<= start end)
      (if (= start end)
          ; Leaf node: update its value
          (vector-set! tree node (max (vector-ref tree node) val))
          ; Internal node: recurse on children
          (let* ((mid (+ start (quotient (- end start) 2)))
                 (left-child (* 2 node))
                 (right-child (+ (* 2 node) 1)))
            (if (<= idx mid)
                (update left-child start mid idx val)
                (update right-child (+ mid 1) end idx val))
            ; Update parent node with the maximum of its children's values
            (vector-set! tree node (max (vector-ref tree left-child) (vector-ref tree right-child)))))))

  ; Segment tree query function
  ; Returns the maximum value in the range [l, r].
  (define (query node start end l r)
    (cond
      ; Case 1: No overlap between the current segment [start, end] and the query range [l, r]
      ((or (> start r) (> l end)) 0) ; Return 0 as it doesn't contribute to the maximum
      ; Case 2: Complete overlap: Current segment [start, end] is fully within [l, r]
      ((and (>= start l) (<= end r)) (vector-ref tree node))
      ; Case 3: Partial overlap: Recurse on children
      (else
       (let* ((mid (+ start (quotient (- end start) 2)))
              (left-child (* 2 node))
              (right-child (+ (* 2 node) 1)))
         (max (query left-child start mid l r)
              (query right-child (+ mid 1) end l r))))))

  (define max-overall-len 0)

  ; Iterate through each number in the input array `nums`
  (for-each (lambda (num)
              ; Determine the valid range for previous values `prev_val`
              ; such that `num - prev_val <= k` (i.e., `prev_val >= num - k`)
              ; and `prev_val < num`.
              ; Also, `prev_val` must be at least 1.
              (define prev-val-min (max 1 (- num k)))
              (define prev-val-max (- num 1))

              ; Query the segment tree to find the maximum LIS length
              ; ending with a value in the range [prev-val-min, prev-val-max].
              ; If prev-val-min > prev-val-max, the query will correctly return 0.
              (define prev-max-lis-len (query 1 1 MAX_NUM_VAL prev-val-min prev-val-max))

              ; The new LIS length ending with `num` is 1 + (max length from valid previous values)
              (define current-lis-len (+ 1 prev-max-lis-len))

              ; Update the segment tree: store `current-lis-len` for `num`.
              ; This effectively sets `dp[num] = current-lis-len`.
              (update 1 1 MAX_NUM_VAL num current-lis-len)

              ; Keep track of the maximum LIS length found across all numbers
              (set! max-overall-len (max max-overall-len current-lis-len)))
            nums)

  max-overall-len)