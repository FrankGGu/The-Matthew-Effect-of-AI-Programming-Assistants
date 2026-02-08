(define (min-cut s)
  (let* ((n (string-length s))
         (pal (make-vector n))) ; pal[i][j] is true if s[i...j] is a palindrome

    (when (= n 0)
      (error "Empty string is not allowed by problem constraints, but handled for robustness.")) ; LeetCode constraints usually 1 <= s.length <= 2000
    (when (= n 0)
      (return 0)) ; Return 0 cuts for an empty string

    ; Initialize pal vector of vectors
    (for ((i 0 n))
      (vector-set! pal i (make-vector n #f)))

    ; Precompute palindromes
    ; pal[i][j] is true if s[i...j] is a palindrome
    ; Iterate i from n-1 down to 0
    ; Iterate j from i to n-1
    (for ((i (- n 1) -1))
      (for ((j i n))
        (vector-set! (vector-ref pal i) j
                     (cond
                       ((= i j) #t) ; Single character is always a palindrome
                       ((= (- j i) 1) (char=? (string-ref s i) (string-ref s j))) ; Two characters
                       (else (and (char=? (string-ref s i) (string-ref s j)) ; More than two characters
                                  (vector-ref (vector-ref pal (+ i 1)) (- j 1))))))))

    (let ((dp (make-vector (+ n 1) 0))) ; dp[i] is the minimum cuts for the suffix s[i...n-1]

      ; dp[n] = 0 cuts for an empty string (suffix starting at n)
      (vector-set! dp n 0)

      ; Compute dp values for suffixes s[i...n-1]
      ; Iterate i from n-1 down to 0
      (for ((i (- n 1) -1))
        ; Initialize dp[i] with the maximum possible cuts: cut after every character
        ; For a string of length L, max cuts = L-1. Length of s[i...n-1] is n-i.
        ; So, max cuts = (n-i) - 1 = n - 1 - i.
        (vector-set! dp i (- n 1 i))

        ; Inner loop: try all possible first palindrome partitions s[i...j]
        ; Iterate j from i to n-1
        (let loop-j ((j i))
          (when (< j n)
            (when (vector-ref (vector-ref pal i) j) ; If s[i...j] is a palindrome
              (if (= j (- n 1)) ; If the entire suffix s[i...n-1] is a palindrome
                  (vector-set! dp i 0) ; Then 0 cuts are needed for this suffix
                  (vector-set! dp i (min (vector-ref dp i) ; Otherwise, 1 cut + min cuts for the rest
                                         (+ 1 (vector-ref dp (+ j 1)))))))
            ; If dp[i] has become 0, it means we found that s[i...n-1] is a palindrome
            ; (or can be partitioned into a single palindrome), so no need to check further partitions.
            (unless (= (vector-ref dp i) 0)
              (loop-j (+ j 1)))))) ; Continue inner loop if dp[i] is not 0

      (vector-ref dp 0)))) ; The result is the minimum cuts for the entire string s[0...n-1]