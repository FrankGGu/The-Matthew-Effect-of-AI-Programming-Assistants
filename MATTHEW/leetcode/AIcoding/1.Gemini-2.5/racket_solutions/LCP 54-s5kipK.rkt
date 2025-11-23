#lang racket

(define (min-time-to-make-array-sum-at-most-x nums1 nums2 x)
  (define n (vector-length nums1))

  (define pairs (make-vector n))
  (for ([i (in-range n)])
    (vector-set! pairs i (list (vector-ref nums1 i) (vector-ref nums2 i))))

  ;; Sort pairs by nums2[i] in ascending order.
  ;; If nums2[i] are equal, sort by nums1[i] in ascending order for stability.
  (define sorted-pairs (sort (vector->list pairs)
                             (lambda (p1 p2)
                               (let ([n2-1 (second p1)]
                                     [n2-2 (second p2)])
                                 (if (= n2-1 n2-2)
                                     (< (first p1) (first p2))
                                     (< n2-1 n2-2))))))

  (define sum-n1 (for/sum ([val (in-vector nums1)]) val))
  (define sum-n2 (for/sum ([val (in-vector nums2)]) val))

  ;; dp[j] represents the maximum value of `sum_{chosen_i} (k - (p_i-1)) * nums2[i]`
  ;; where `k` is the total number of operations and `p_i` is the 1-indexed order
  ;; of choosing item `i`.
  ;; This is achieved by a common transformation for this problem:
  ;; `dp[j]` stores `min(sum_{chosen_i} (nums1[i] + j * nums2[i]))`
  ;; where `j` is the count of operations.
  ;; The final total sum check `sum-n1 + k * sum-n2 - dp[k]` then works out.

  ;; Initialize dp array. dp[0] = 0, dp[j] = +infinity for j > 0.
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  ;; Iterate through each item (n1, n2) from the sorted list.
  (for ([i (in-range n)]
        [pair sorted-pairs])
    (let ([n1 (first pair)]
          [n2 (second pair)])
      ;; For each item, update dp states for choosing j items.
      ;; Iterate j from current item count (i+1) down to 1.
      (for ([j (in-range (add1 i) 0 -1)])
        (vector-set! dp j (min (vector-ref dp j)
                               (+ (vector-ref dp (- j 1)) n1 (* j n2)))))))

  ;; Find the minimum k (number of operations) that satisfies the condition.
  (for/first ([k (in-range (+ n 1))])
    (when (not (= (vector-ref dp k) +inf.0))
      ;; Calculate the total sum for k operations.
      ;; This formula is specific to the DP state used.
      (define current-total-sum (- (+ sum-n1 (* k sum-n2)) (vector-ref dp k)))
      (when (<= current-total-sum x)
        k)))
  )