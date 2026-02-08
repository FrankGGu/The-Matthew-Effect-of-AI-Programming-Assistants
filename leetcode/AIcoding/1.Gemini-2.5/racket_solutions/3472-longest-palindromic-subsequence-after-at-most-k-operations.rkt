(define (longest-palindromic-subsequence-after-k-operations s k)
  (define n (string-length s))

  (if (= n 0)
      0
      (begin
        ; dp[i][j][c] stores the maximum length of a palindromic subsequence
        ; for the substring s[i...j] using exactly 'c' character changes.
        (define dp (make-vector n))
        (for ([i (in-range n)])
          (vector-set! dp i (make-vector n)))
        (for ([i (in-range n)])
          (for ([j (in-range n)])
            (vector-set! (vector-ref dp i) j (make-vector (add1 k) 0))))

        ; Base cases: A single character is a palindrome of length 1,
        ; requiring 0 changes. This applies for any available 'c'.
        (for ([i (in-range n)])
          (for ([c (in-range (add1 k))])
            (vector-set! (vector-ref (vector-ref dp i) i) c 1)))

        ; Fill the DP table for increasing substring lengths (len)
        (for ([len (in-range 2 (add1 n))])
          (for ([i (in-range (- n len -1))]) ; 'i' is the starting index
            (define j (+ i len -1)) ; 'j' is the ending index
            (define char-i (string-ref s i))
            (define char-j (string-ref s j))

            ; Iterate through all possible counts of changes 'c'
            (for ([c (in-range (add1 k))])
              ; Option 1: Do not include s[i] or s[j] in the current palindromic subsequence.
              ; The length is inherited from subproblems where s[i] or s[j] is excluded.
              (define val-from-i+1-j (vector-ref (vector-ref dp (add1 i)) j c))
              (define val-from-i-j-1 (vector-ref (vector-ref dp i) (sub1 j) c))
              (vector-set! (vector-ref (vector-ref dp i) j) c (max val-from-i+1-j val-from-i-j-1))

              ; Option 2: Try to include s[i] and s[j] in the palindromic subsequence.
              (cond
                [(= char-i char-j)
                 ; If s[i] and s[j] are the same, they can form a pair without using a change.
                 ; The length is 2 (for s[i] and s[j]) plus the length of the inner subsequence s[i+1...j-1].
                 ; If len is 2, the inner string s[i+1...j-1] is empty, so its length is 0.
                 (define inner-val (if (> len 2)
                                       (vector-ref (vector-ref dp (add1 i)) (sub1 j) c)
                                       0))
                 (vector-set! (vector-ref (vector-ref dp i) j) c
                              (max (vector-ref (vector-ref dp i) j c) (+ 2 inner-val)))]
                [(> c 0)
                 ; If s[i] and s[j] are different, they can form a pair by using one change (if 'c' is available).
                 ; The length is 2 (for s[i] and s[j]) plus the length of the inner subsequence s[i+1...j-1],
                 ; using one fewer change (c-1) for the inner part.
                 ; If len is 2, the inner string s[i+1...j-1] is empty, so its length is 0.
                 (define inner-val (if (> len 2)
                                       (vector-ref (vector-ref dp (add1 i)) (sub1 j) (sub1 c))
                                       0))
                 (vector-set! (vector-ref (vector-ref dp i) j) c
                              (max (vector-ref (vector-ref dp i) j c) (+ 2 inner-val)))])))
        )

        ; The final answer is the maximum length found for the entire string s[0...n-1]
        ; across all possible change counts from 0 to k.
        (define max-len 0)
        (for ([c (in-range (add1 k))])
          (set! max-len (max max-len (vector-ref (vector-ref dp 0) (- n 1) c))))
        max-len)))