#lang racket

(define (minimum-incompatibility nums k)
  (define n (length nums))
  (define group-size (/ n k))

  ;; Convert nums to a vector for O(1) access by index
  (define nums-vec (list->vector nums))

  ;; Helper to count set bits in a mask
  (define (popcount mask)
    (let loop ((m mask) (count 0))
      (if (zero? m)
          count
          (loop (bitwise-and m (sub1 m)) (add1 count)))))

  ;; Helper to calculate incompatibility for a given mask
  ;; Assumes mask has at least one bit set.
  ;; If group-size is 1, incompatibility is 0.
  (define (calculate-incompatibility mask)
    (let loop ((j 0) (min-val +inf.0) (max-val -inf.0))
      (if (= j n)
          (- max-val min-val)
          (if (bitwise-bit-set? mask j)
              (let ((val (vector-ref nums-vec j)))
                (loop (add1 j) (min min-val val) (max max-val val)))
              (loop (add1 j) min-val max-val)))))

  ;; Helper to find the index of the least significant bit set in a mask
  (define (find-first-set-bit mask)
    (let loop ((j 0))
      (if (= j n) -1 ; Should not happen for non-zero mask
          (if (bitwise-bit-set? mask j) j (loop (add1 j))))))

  ;; DP array: dp[mask] stores min incompatibility for elements represented by mask
  (define dp (make-vector (expt 2 n) +inf.0))
  (vector-set! dp 0 0)

  ;; Iterate through masks from 1 to 2^n - 1
  (for ((mask (in-range 1 (expt 2 n))))
    ;; Only consider masks that represent a complete number of groups
    ;; (i.e., popcount is a multiple of group-size)
    (when (zero? (modulo (popcount mask) group-size))
      ;; Optimization: To avoid redundant calculations and ensure each partition
      ;; is considered exactly once, we fix the smallest indexed element in `mask`
      ;; to be part of the current group being formed.
      (define first-bit-idx (find-first-set-bit mask))
      (define first-bit-mask (expt 2 first-bit-idx))

      ;; Recursive helper to generate combinations for the current group
      ;; `current-idx`: The smallest index to consider for the next element in the group.
      ;; `count`: The number of elements already selected for `current-group-submask`.
      ;; `current-group-submask`: The bitmask representing elements chosen for the current group.
      (let generate-combinations ((current-idx (add1 first-bit-idx))
                                  (count 1)
                                  (current-group-submask first-bit-mask))
        ;; Pruning: Only continue if we haven't exceeded the required group size
        (when (<= count group-size)
          (if (= count group-size)
              ;; Base case: A complete group of `group-size` elements is formed.
              (let* ((inc (calculate-incompatibility current-group-submask))
                     (prev-mask (bitwise-xor mask current-group-submask)))
                ;; If the previous state (mask without the current group) is reachable,
                ;; update dp[mask].
                (when (not (= (vector-ref dp prev-mask) +inf.0))
                  (vector-set! dp mask
                               (min (vector-ref dp mask)
                                    (+ (vector-ref dp prev-mask) inc)))))
              ;; Recursive step: Need more elements to complete the current group.
              (for ((next-idx (in-range current-idx n)))
                ;; Only consider elements that are part of the original `mask`
                ;; (i.e., available elements not yet partitioned)
                (when (bitwise-bit-set? mask next-idx)
                  (generate-combinations (add1 next-idx)
                                         (add1 count)
                                         (bitwise-ior current-group-submask (expt 2 next-idx))))))))))

  ;; The result is the minimum incompatibility for the mask containing all elements.
  (define final-mask (sub1 (expt 2 n)))
  (define result (vector-ref dp final-mask))

  ;; According to problem constraints, a solution always exists,
  ;; so `result` will not be +inf.0.
  result)