#lang racket

(define (maximum-deletions s)
  (define n (string-length s))

  ;; lcp[i][j] stores the length of the longest common prefix of s[i...] and s[j...]
  (define lcp (make-vector n))
  (for ([k (in-range n)])
    (vector-set! lcp k (make-vector n 0)))

  ;; Compute lcp table
  ;; Iterate from n-1 down to 0 for both i and j
  (for ([i (in-range (- n 1) -1 -1)])
    (for ([j (in-range (- n 1) -1 -1)])
      (if (char=? (string-ref s i) (string-ref s j))
          ;; If characters match, LCP is 1 + LCP of next characters
          (if (and (< (+ i 1) n) (< (+ j 1) n))
              (vector-set! (vector-ref lcp i) j (+ 1 (vector-ref (vector-ref lcp (+ i 1)) (+ j 1))))
              ;; If at the end of string, LCP is 1
              (vector-set! (vector-ref lcp i) j 1))
          ;; If characters don't match, LCP is 0
          (vector-set! (vector-ref lcp i) j 0))))

  ;; dp[i] stores the maximum number of operations to delete the suffix s[i...]
  ;; dp array size n+1 to handle dp[n] (empty string)
  (define dp (make-vector (+ n 1) 0))

  ;; Compute dp table
  ;; Iterate from n-1 down to 0
  (for ([i (in-range (- n 1) -1 -1)])
    ;; Option 1: Always possible to delete the entire remaining string s[i...] in 1 operation
    (vector-set! dp i 1)

    ;; Option 2: Find the longest prefix p of s[i...] such that p also matches the substring
    ;; starting at i+len. If such a p exists, delete p and recursively solve for s[i+len...].
    ;; The problem specifies "Find the longest prefix p", meaning we must choose the largest 'len'.
    (define longest-matching-len -1)
    ;; 'len' can be from 1 up to (n-i)/2.
    ;; (quotient (- n i) 2) gives floor((n-i)/2).
    ;; (add1 ...) makes the range inclusive of the upper bound.
    (for ([len (in-range 1 (add1 (quotient (- n i) 2)))])
      ;; Check if s[i...i+len-1] == s[i+len...i+2*len-1]
      ;; This is true if the longest common prefix of s[i...] and s[i+len...] is at least 'len'
      (when (>= (vector-ref (vector-ref lcp i) (+ i len)) len)
        ;; If a match is found, update longest-matching-len.
        ;; Since we iterate 'len' in increasing order, the last 'len' that satisfies the condition
        ;; will be the longest one.
        (set! longest-matching-len len)))

    ;; If a valid 'longest-matching-len' was found, consider this option
    (when (!= longest-matching-len -1)
      ;; The number of operations is 1 (for deleting p) + max operations for the remaining string s[i+longest-matching-len...]
      (vector-set! dp i (max (vector-ref dp i) (+ 1 (vector-ref dp (+ i longest-matching-len)))))))

  ;; The result is the maximum operations for the entire string s (from index 0)
  (vector-ref dp 0))