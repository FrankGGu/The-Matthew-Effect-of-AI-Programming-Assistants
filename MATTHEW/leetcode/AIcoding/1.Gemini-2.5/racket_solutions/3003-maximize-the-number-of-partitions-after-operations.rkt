#lang racket

(define (maximize-the-number-of-partitions-after-operations s k)
  (define n (string-length s))

  ;; dp[i][0] = maximum partitions for s[0...i-1] without using the one-change operation
  ;; dp[i][1] = maximum partitions for s[0...i-1] having used the one-change operation
  ;; Initialize with -1 to indicate unreachable states.
  ;; dp[0][0] is 0, representing 0 partitions for an empty prefix without any change.
  (define dp (make-vector (+ n 1) (lambda () (vector -1 -1))))
  (vector-set! (vector-ref dp 0) 0 0) ; dp[0][0] = 0

  (for ([i (in-range 1 (+ n 1))])
    (define freq (make-vector 26 0)) ; Frequency map for current substring s[j...i-1]
    (define distinct-count 0)

    ;; Iterate j backwards from i-1 to 0 to form substrings s[j...i-1]
    (for ([j (in-range (- i 1) -1 -1)])
      (define char-code (- (char->integer (string-ref s j)) (char->integer #\a)))

      (when (= (vector-ref freq char-code) 0)
        (set! distinct-count (+ distinct-count 1)))
      (vector-set! freq char-code (+ (vector-ref freq char-code) 1))

      ;; Update dp[i][0] (no change used for s[0...i-1])
      ;; This partition s[j...i-1] must satisfy distinct-count <= k without a change.
      (when (<= distinct-count k)
        (when (>= (vector-ref (vector-ref dp j) 0) 0) ; if dp[j][0] is reachable
          (vector-set! (vector-ref dp i) 0 
                       (max (vector-ref (vector-ref dp i) 0) 
                            (+ (vector-ref (vector-ref dp j) 0) 1)))))

      ;; Update dp[i][1] (change used for s[0...i-1])
      ;; Option 1: The change was already used in s[0...j-1].
      ;; This partition s[j...i-1] must satisfy distinct-count <= k without a new change.
      (when (<= distinct-count k)
        (when (>= (vector-ref (vector-ref dp j) 1) 0) ; if dp[j][1] is reachable
          (vector-set! (vector-ref dp i) 1 
                       (max (vector-ref (vector-ref dp i) 1) 
                            (+ (vector-ref (vector-ref dp j) 1) 1)))))

      ;; Option 2: The change is used in the current partition s[j...i-1].
      ;; This partition can be made valid if distinct-count <= k + 1.
      ;; (If distinct-count is k+1, we can change one char to reduce it to k).
      ;; The prefix s[0...j-1] must not have used a change (dp[j][0]).
      (when (<= distinct-count (+ k 1)) 
        (when (>= (vector-ref (vector-ref dp j) 0) 0) ; if dp[j][0] is reachable
          (vector-set! (vector-ref dp i) 1 
                       (max (vector-ref (vector-ref dp i) 1) 
                            (+ (vector-ref (vector-ref dp j) 0) 1)))))))

  (define result-0 (vector-ref (vector-ref dp n) 0))
  (define result-1 (vector-ref (vector-ref dp n) 1))

  (max result-0 result-1))