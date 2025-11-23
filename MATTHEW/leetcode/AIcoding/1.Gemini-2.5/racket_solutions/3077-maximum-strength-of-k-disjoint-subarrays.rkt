#lang racket

(define (maximum-strength-of-k-disjoint-subarrays nums k)
  (define n (length nums))
  (define neg-inf -9e18) ; A sufficiently small number for initial DP values.

  ; Convert nums to a vector for O(1) access
  (define nums-vec (list->vector nums))

  ; dp[k_idx][i] = maximum strength using k_idx disjoint subarrays,
  ; where the k_idx-th subarray ends at index i.
  ; k_idx ranges from 1 to K. i ranges from 0 to n-1.
  (define dp (make-vector (+ k 1)))
  (for ((row (in-range (+ k 1))))
    (vector-set! dp row (make-vector n neg-inf)))

  ; Fill dp table
  (for ((cur-k 1 (add1 cur-k))) ; cur-k from 1 to K
    (let* ((current-k-dp-row (vector-ref dp cur-k))
           (prev-k-dp-row (vector-ref dp (- cur-k 1)))
           (max-dp-prev-k (make-vector n neg-inf))) ; Auxiliary array for max_{0 <= p <= x} dp[cur-k-1][p]

      ; Populate max-dp-prev-k for the previous k
      ; max-dp-prev-k[x] will store max_{0 <= p <= x} dp[cur-k-1][p]
      (when (> n 0)
        (vector-set! max-dp-prev-k 0 (vector-ref prev-k-dp-row 0))
        (for ((x 1 (add1 x)))
          (vector-set! max-dp-prev-k x
                       (max (vector-ref max-dp-prev-k (- x 1))
                            (vector-ref prev-k-dp-row x)))))

      (for ((i 0 (add1 i))) ; i is the end index of the current subarray
        (let ((current-sub-sum 0))
          (for ((j i (- j 1))) ; j is the start index of the current subarray, iterate backwards from i to 0
            (set! current-sub-sum (+ current-sub-sum (vector-ref nums-vec j)))
            (let* ((sub-len (+ (- i j) 1))
                   (current-strength (* current-sub-sum sub-len)))

              (if (= cur-k 1)
                  ; Base case for k=1: no previous subarrays needed.
                  (vector-set! current-k-dp-row i
                               (max (vector-ref current-k-dp-row i) current-strength))
                  ; For k > 1: need to combine with a previous state.
                  (when (> j 0) ; Previous subarray must end before j
                    (let ((prev-max-val (vector-ref max-dp-prev-k (- j 1))))
                      (when (not (= prev-max-val neg-inf))
                        (vector-set! current-k-dp-row i
                                     (max (vector-ref current-k-dp-row i)
                                          (+ prev-max-val current-strength))))))))))))

  ; The final answer is the maximum value in the last row of dp (for k=K)
  (let ((max-total-strength neg-inf))
    (for ((i (in-range n)))
      (set! max-total-strength (max max-total-strength (vector-ref (vector-ref dp k) i))))
    max-total-strength))