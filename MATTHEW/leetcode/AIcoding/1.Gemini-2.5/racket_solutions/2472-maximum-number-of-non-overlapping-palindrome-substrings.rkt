(define (maximum-number-of-non-overlapping-palindrome-substrings s k)
  (define n (string-length s))

  ;; is_pal[i][j] will be true if s[i...j] is a palindrome
  ;; Using a vector of vectors for a 2D boolean array
  (define is_pal (make-vector n #f))
  (for ([i (in-range n)])
    (vector-set! is_pal i (make-vector n #f)))

  ;; Populate is_pal table
  ;; Base cases: single characters (length 1)
  (for ([i (in-range n)])
    (vector-set! (vector-ref is_pal i) i #t))

  ;; Base cases: two identical adjacent characters (length 2)
  (for ([i (in-range (- n 1))]) ;; i from 0 to n-2
    (when (char=? (string-ref s i) (string-ref s (+ i 1)))
      (vector-set! (vector-ref is_pal i) (+ i 1) #t)))

  ;; General case: length >= 3
  (for ([len (in-range 3 (+ n 1))]) ;; len from 3 to n
    (for ([i (in-range (- n len -1))]) ;; i from 0 to n-len
      (define j (+ i len -1)) ;; j is the end index for substring s[i...j]
      (when (and (char=? (string-ref s i) (string-ref s j))
                 (vector-ref (vector-ref is_pal (+ i 1)) (- j 1)))
        (vector-set! (vector-ref is_pal i) j #t))))

  ;; dp[i] = maximum number of non-overlapping palindrome substrings in s[0...i-1]
  ;; dp array size n+1, indexed from 0 to n
  (define dp (make-vector (+ n 1) 0))

  ;; Iterate i from 1 to n (representing prefix s[0...i-1])
  (for ([i (in-range 1 (+ n 1))])
    ;; Case 1: Do not include s[i-1] in any new palindrome.
    ;; The count is the same as for the prefix s[0...i-2].
    (vector-set! dp i (vector-ref dp (- i 1)))

    ;; Case 2: s[i-1] is the end of a new palindrome s[j...i-1].
    ;; This palindrome must have length >= k.
    ;; Length = (i-1) - j + 1 = i - j. So, i - j >= k => j <= i - k.
    ;; j can range from 0 to i-k.
    (for ([j (in-range (- i k -1))]) ;; j from 0 to i-k
      (define current-end-idx (- i 1))
      (define current-start-idx j)

      ;; Check if s[j...i-1] is a palindrome
      (when (vector-ref (vector-ref is_pal current-start-idx) current-end-idx)

        ;; If s[j...i-1] is a valid palindrome, we can potentially include it.
        ;; The previous non-overlapping palindromes must end before index j.
        ;; Their count is dp[j].
        (define prev-dp-val (vector-ref dp j))
        (vector-set! dp i (max (vector-ref dp i) (+ 1 prev-dp-val))))))

  ;; The result is the maximum count considering the entire string s[0...n-1]
  (vector-ref dp n))