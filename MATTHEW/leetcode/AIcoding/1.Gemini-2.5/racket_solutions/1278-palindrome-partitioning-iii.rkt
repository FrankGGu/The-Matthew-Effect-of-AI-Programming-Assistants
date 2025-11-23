(define (palindrome-partitioning-iii s k)
  (define n (string-length s))

  ;; Precompute cost to make s[i...j] a palindrome
  ;; cost-table[i][j] stores the minimum changes to make substring s[i...j] a palindrome.
  (define cost-table (make-vector n (make-vector n)))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (let loop ([left i] [right j] [changes 0])
        (if (< left right)
            (loop (+ left 1) (- right 1)
                  (if (char=? (string-ref s left) (string-ref s right))
                      changes
                      (+ changes 1)))
            (vector-set! (vector-ref cost-table i) j changes)))))

  ;; dp[i][j] = minimum changes to partition the prefix s[0...i-1] into j palindromic substrings.
  ;; i represents the length of the prefix (from 0 to n).
  ;; j represents the number of partitions (from 0 to k).
  (define dp (make-vector (+ n 1) (make-vector (+ k 1) +inf.0)))

  ;; Base case: 0 changes for an empty prefix with 0 partitions.
  (vector-set! (vector-ref dp 0) 0 0)

  ;; Iterate over the number of partitions
  (for ([j (in-range 1 (+ k 1))])
    ;; Iterate over the current prefix length
    (for ([i (in-range 1 (+ n 1))])
      ;; A prefix of length 'i' must be at least 'j' to be partitioned into 'j' parts.
      (when (>= i j)
        ;; Iterate over possible split points for the last partition.
        ;; 'prev-len' is the length of the prefix s[0...prev-len-1] that forms (j-1) partitions.
        ;; 'prev-len' must be at least (j-1) to have (j-1) partitions.
        ;; 'prev-len' must be less than 'i' because the current segment must be non-empty.
        (for ([prev-len (in-range (- j 1) i)])
          (let ([prev-cost (vector-ref (vector-ref dp prev-len) (- j 1))])
            ;; If it's impossible to form (j-1) partitions for prev-len, skip.
            (unless (= prev-cost +inf.0)
              (let* ([current-segment-start-idx prev-len]
                     [current-segment-end-idx (- i 1)]
                     [current-segment-cost (vector-ref (vector-ref cost-table current-segment-start-idx) current-segment-end-idx)])
                (vector-set! (vector-ref dp i) j
                             (min (vector-ref (vector-ref dp i) j)
                                  (+ prev-cost current-segment-cost))))))))))

  ;; The result is the minimum changes to partition the entire string s (length n) into k parts.
  (vector-ref (vector-ref dp n) k))