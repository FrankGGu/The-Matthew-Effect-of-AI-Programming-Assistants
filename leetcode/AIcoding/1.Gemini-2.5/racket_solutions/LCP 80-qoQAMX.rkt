(define (longest-common-subsequence-with-k-diff s t k)
  (let* ((s-len (string-length s))
         (t-len (string-length t))
         (diff-offset 1000) ; Offset to handle negative differences (A_count - B_count)
         (diff-range 2001)  ; Range of differences: -1000 to 1000, so 2001 states

         ;; dp-rows is a vector of two 2D vectors.
         ;; Each 2D vector represents a row (for current i or previous i)
         ;; and stores max_len for (j, diff_idx)
         (dp-rows (build-vector 2
                                (lambda (idx)
                                  (build-vector (+ t-len 1)
                                                (lambda (j)
                                                  (build-vector diff-range (lambda (k) -1)))))))
         (prev-idx 0)
         (curr-idx 1))

    ;; Initialize dp[0][0][diff_offset] = 0. This means for empty s and empty t,
    ;; LCS length is 0, and A_count - B_count is 0.
    (vector-set! (vector-ref (vector-ref (vector-ref dp-rows prev-idx) 0) diff-offset) 0)

    (for ([i (in-range 1 (+ s-len 1))])
      (set! curr-idx (modulo i 2))
      (set! prev-idx (modulo (- i 1) 2))

      ;; Clear the current row for new calculations
      (for ([j (in-range 0 (+ t-len 1))])
        (for ([d-idx (in-range 0 diff-range)])
          (vector-set! (vector-ref (vector-ref (vector-ref dp-rows curr-idx) j) d-idx) -1)))

      ;; Base case for curr_dp[0] (empty t string): LCS length is 0, diff is 0.
      (vector-set! (vector-ref (vector-ref (vector-ref dp-rows curr-idx) 0) diff-offset) 0)

      (for ([j (in-range 1 (+ t-len 1))])
        (for ([d-idx (in-range 0 diff-range)])
          ;; Option 1: Skip s[i-1]
          ;; Inherit from dp[i-1][j][d_idx] (which is prev_dp[j][d_idx])
          (let ((val-prev-j (vector-ref (vector-ref (vector-ref dp-rows prev-idx) j) d-idx)))
            (when (not (= val-prev-j -1))
              (vector-set! (vector-ref (vector-ref (vector-ref dp-rows curr-idx) j) d-idx)
                           (max (vector-ref (vector-ref (vector-ref dp-rows curr-idx) j) d-idx)
                                val-prev-j))))

          ;; Option 2: Skip t[j-1]
          ;; Inherit from dp[i][j-1][d_idx] (which is curr_dp[j-1][d_idx])
          (let ((val-curr-j-1 (vector-ref (vector-ref (vector-ref dp-rows curr-idx) (- j 1)) d-idx)))
            (when (not (= val-curr-j-1 -1))
              (vector-set! (vector-ref (vector-ref (vector-ref dp-rows curr-idx) j) d-idx)
                           (max (vector-ref (vector-ref (vector-ref dp-rows curr-idx) j) d-idx)
                                val-curr-j-1))))

          ;; Option 3: Match s[i-1] and t[j-1]
          (when (char=? (string-ref s (- i 1)) (string-ref t (- j 1)))
            (let* ((char (string-ref s (- i 1)))
                   (prev-len (vector-ref (vector-ref (vector-ref dp-rows prev-idx) (- j 1)) d-idx)))
              (when (not (= prev-len -1))
                (let* ((current-diff (- d-idx diff-offset))
                       (new-diff (cond
                                   ((char=? char #\A) (+ current-diff 1))
                                   ((char=? char #\B) (- current-diff 1))
                                   (else current-diff)))
                       (new-d-idx (+ new-diff diff-offset)))
                  (when (and (>= new-d-idx 0) (< new-d-idx diff-range))
                    (vector-set! (vector-ref (vector-ref (vector-ref dp-rows curr-idx) j) new-d-idx)
                                 (max (vector-ref (vector-ref (vector-ref dp-rows curr-idx) j) new-d-idx)
                                      (+ 1 prev-len))))))))))

    ;; The final answer is dp[s_len][t_len][k + diff_offset]
    (let ((result (vector-ref (vector-ref (vector-ref dp-rows curr-idx) t-len) (+ k diff-offset))))
      result)))

(provide (rename-out [longest-common-subsequence-with-k-diff biological-evolution-record]))