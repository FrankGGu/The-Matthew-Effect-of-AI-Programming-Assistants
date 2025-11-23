#lang racket

(define (solve nums k)
  (define n (vector-length nums))
  (when (= n 0)
    (error 'solve "Input array cannot be empty")) ; LeetCode usually guarantees non-empty or expects 0 for empty.

  ;; --- Coordinate Compression ---
  ;; Collect all relevant values (nums[i], nums[i]-k, nums[i]+k) to create a sorted unique list.
  (define all-coords (make-hasheq)) ; Using a hash set to collect unique values.
  (for ([x (in-vector nums)])
    (hash-set! all-coords x #t)
    (hash-set! all-coords (- x k) #t)
    (hash-set! all-coords (+ x k) #t))

  (define sorted-unique-coords (vector-sort (hash-keys all-coords) <)) ; Sort keys and convert to vector for efficient lookup.

  (define coord-to-idx (make-hasheq)) ; Map original values to their compressed indices.
  (for ([i (in-range (vector-length sorted-unique-coords))])
    (hash-set! coord-to-idx (vector-ref sorted-unique-coords i) i))

  (define m (vector-length sorted-unique-coords)) ; Number of unique compressed coordinates.

  ;; --- Segment Tree Implementation ---
  ;; The segment tree will store maximum lengths. Initialized to 0.
  ;; Tree nodes are 1-indexed, covering the 0-indexed compressed coordinate range [0, m-1].
  (define tree-size (* 4 m)) ; A common heuristic for segment tree array size.
  (define tree (make-vector tree-size 0))

  ;; Function to update a value in the segment tree.
  ;; `node-idx`: current node's index in the `tree` vector.
  ;; `node-low`, `node-high`: the range of compressed indices covered by `node-idx`.
  ;; `target-idx`: the specific compressed index to update.
  ;; `new-val`: the new length to update with (take max with existing value).
  (define (update node-idx node-low node-high target-idx new-val)
    (cond
      [(= node-low node-high) ; Leaf node reached.
       (vector-set! tree node-idx (max (vector-ref tree node-idx) new-val))]
      [else
       (define mid (+ node-low (quotient (- node-high node-low) 2)))
       (define left-child (* 2 node-idx))
       (define right-child (+ (* 2 node-idx) 1))

       (if (<= target-idx mid)
           (update left-child node-low mid target-idx new-val)
           (update right-child (+ mid 1) node-high target-idx new-val))

       ;; Update current node after children are updated.
       (vector-set! tree node-idx (max (vector-ref tree left-child) (vector-ref tree right-child)))]))

  ;; Function to query the maximum value in a given range.
  ;; `node-idx`: current node's index in the `tree` vector.
  ;; `node-low`, `node-high`: the range of compressed indices covered by `node-idx`.
  ;; `query-low`, `query-high`: the range of compressed indices to query.
  (define (query node-idx node-low node-high query-low query-high)
    ;; No overlap between node's range and query range.
    (if (or (> node-low query-high) (< node-high query-low))
        0 ; Return identity for max (0).
        ;; Full overlap.
        (if (and (>= node-low query-low) (<= node-high query-high))
            (vector-ref tree node-idx)
            ;; Partial overlap, recurse on children.
            (begin
              (define mid (+ node-low (quotient (- node-high node-low) 2)))
              (define left-child (* 2 node-idx))
              (define right-child (+ (* 2 node-idx) 1))
              (max (query left-child node-low mid query-low query-high)
                   (query right-child (+ mid 1) node-high query-low query-high))))))

  ;; --- Binary Search for Compressed Indices (lower_bound and upper_bound) ---
  ;; Finds the index of the first element >= val in `sorted-unique-coords`.
  ;; Returns `m` if no such element exists.
  (define (lower-bound val)
    (let loop ([low 0] [high (- m 1)] [ans m])
      (if (<= low high)
          (let ([mid (+ low (quotient (- high low) 2))])
            (if (>= (vector-ref sorted-unique-coords mid) val)
                (loop low (- mid 1) mid)
                (loop (+ mid 1) high ans)))
          ans)))

  ;; Finds the index of the last element <= val in `sorted-unique-coords`.
  ;; Returns `-1` if no such element exists.
  (define (upper-bound val)
    (let loop ([low 0] [high (- m 1)] [ans -1])
      (if (<= low high)
          (let ([mid (+ low (quotient (- high low) 2))])
            (if (<= (vector-ref sorted-unique-coords mid) val)
                (loop (+ mid 1) high mid)
                (loop low (- mid 1) ans)))
          ans)))

  ;; --- Main DP Loop ---
  (define max-len 0)

  (for ([x (in-vector nums)])
    ;; Get the compressed index for the current number `x`.
    (define current-val-idx (hash-ref coord-to-idx x))

    ;; Determine the range of values [x - k, x + k] in the original number space.
    (define query-range-low-val (- x k))
    (define query-range-high-val (+ x k))

    ;; Find the corresponding compressed indices for the query range.
    (define query-low-idx (lower-bound query-range-low-val))
    (define query-high-idx (upper-bound query-range-high-val))

    ;; Query the segment tree for the maximum length ending at a previous number
    ;; whose value falls within [x - k, x + k].
    (define prev-max-len 0)
    ;; Check if the query range of compressed indices is valid.
    (when (and (<= query-low-idx query-high-idx) ; Ensure start index is not greater than end index.
               (< query-low-idx m)                ; Ensure start index is within bounds [0, m-1].
               (>= query-high-idx 0))             ; Ensure end index is within bounds [0, m-1].
      (set! prev-max-len (query 1 0 (- m 1) query-low-idx query-high-idx)))

    ;; The length of the good subsequence ending with `x` is `prev-max-len + 1`.
    (define current-len (+ prev-max-len 1))

    ;; Update the overall maximum length found so far.
    (set! max-len (max max-len current-len))

    ;; Update the segment tree at `current-val-idx` with `current-len`.
    ;; This records the maximum length of a good subsequence ending with `x`.
    (update 1 0 (- m 1) current-val-idx current-len))

  max-len)