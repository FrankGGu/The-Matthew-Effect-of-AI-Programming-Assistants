#lang racket

(define (longest-well-performing-interval hours)
  (define n (vector-length hours))
  (define max-len 0)
  (define current-sum 0)
  (define sum-to-first-idx (make-hash))

  ;; Initialize the hash table with a prefix sum of 0 at index 0.
  ;; This handles intervals that start from the beginning of the `hours` array.
  ;; The index stored in the hash table refers to the index in the conceptual prefix sum array P.
  ;; P[k] is the sum of scores from index 0 up to k-1. So P[0] = 0.
  (hash-set! sum-to-first-idx 0 0)

  (for ([i (in-range n)])
    (define score (if (> (vector-ref hours i) 8) 1 -1))
    (set! current-sum (+ current-sum score))

    ;; If the current prefix sum is positive, the interval from index 0 to `i`
    ;; is well-performing. Its length is `i + 1`.
    (when (> current-sum 0)
      (set! max-len (max max-len (+ i 1))))

    ;; Store the first occurrence of the current prefix sum.
    ;; The index stored is `i + 1`, which corresponds to P[i+1].
    (unless (hash-has-key? sum-to-first-idx current-sum)
      (hash-set! sum-to-first-idx current-sum (+ i 1)))

    ;; If the current prefix sum is not positive (i.e., <= 0),
    ;; we look for a previous prefix sum `P[k]` such that `P[k] < current-sum`.
    ;; To maximize the length `(i+1) - k`, we need `k` to be as small as possible.
    ;; The hash table stores the first occurrence of each prefix sum.
    ;; We specifically check for `current-sum - 1`. If `P[k] = current-sum - 1`,
    ;; then the sum of the subarray from `k` to `i` is `P[i+1] - P[k] = current-sum - (current-sum - 1) = 1`.
    ;; This is a well-performing interval.
    (when (hash-has-key? sum-to-first-idx (- current-sum 1))
      (define prev-sum-idx (hash-ref sum-to-first-idx (- current-sum 1)))
      (set! max-len (max max-len (- (+ i 1) prev-sum-idx))))
    )

  max-len)