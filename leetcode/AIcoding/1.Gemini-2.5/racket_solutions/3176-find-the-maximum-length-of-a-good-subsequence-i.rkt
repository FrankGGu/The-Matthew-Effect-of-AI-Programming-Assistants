(define (maximum-length s k)
  (define n (string-length s))

  ;; Helper function to convert a character to its 0-25 index
  (define (char->idx c)
    (- (char->integer c) (char->integer #\a)))

  ;; dp[j][char_val] stores the maximum length of a good subsequence
  ;; with exactly 'j' differences, ending with the character represented by 'char_val'.
  ;; Initialize all dp values to 0.
  (define dp (make-vector (add1 k) (make-vector 26 0)))

  ;; This variable will store the overall maximum length found.
  (define max-len 0)

  ;; Iterate through each character of the input string s
  (for ([i (in-range n)])
    (define current-char-idx (char->idx (string-ref s i)))

    ;; Create a temporary dp table for updates in this iteration.
    ;; This is crucial to ensure that updates for the current character s[i]
    ;; are based on the dp state *before* processing s[i],
    ;; preventing using values that were already updated by s[i] itself
    ;; for other calculations within the same iteration.
    (define new-dp (make-vector (add1 k)))
    (for ([j (in-range (add1 k))])
      (vector-set! new-dp j (vector-copy (vector-ref dp j))))

    ;; Case 1: The current character s[i] starts a new subsequence of length 1.
    ;; This subsequence has 0 differences.
    (vector-set! (vector-ref new-dp 0)
                 current-char-idx
                 (max (vector-ref (vector-ref new-dp 0) current-char-idx) 1))

    ;; Case 2: The current character s[i] extends a previous subsequence.
    ;; Iterate through all possible previous difference counts (j)
    ;; and all possible previous ending characters (prev-char-idx).
    (for ([j (in-range (add1 k))]) ; j represents the number of differences in the *previous* subsequence
      (for ([prev-char-idx (in-range 26)])
        (define prev-len (vector-ref (vector-ref dp j) prev-char-idx))

        ;; Only consider previous subsequences that actually exist (length > 0)
        (when (> prev-len 0)
          (cond
            ;; If the current character is the same as the previous character,
            ;; no new difference is added.
            [(= current-char-idx prev-char-idx)
             (vector-set! (vector-ref new-dp j)
                          current-char-idx
                          (max (vector-ref (vector-ref new-dp j) current-char-idx)
                               (add1 prev-len)))]
            ;; If the current character is different from the previous character,
            ;; a new difference is added, provided 'j' (previous differences) is less than 'k'.
            [(< j k)
             (vector-set! (vector-ref new-dp (add1 j)) ; (add1 j) means j+1 differences
                          current-char-idx
                          (max (vector-ref (vector-ref new-dp (add1 j)) current-char-idx)
                               (add1 prev-len)))]))))

    ;; After processing all possibilities for the current character s[i],
    ;; update the main dp table with the new_dp values.
    (set! dp new-dp)

    ;; Update the overall maximum length found so far
    (for ([j (in-range (add1 k))])
      (for ([char-idx (in-range 26)])
        (set! max-len (max max-len (vector-ref (vector-ref dp j) char-idx)))))
    )

  ;; Return the maximum length of a good subsequence found
  max-len)