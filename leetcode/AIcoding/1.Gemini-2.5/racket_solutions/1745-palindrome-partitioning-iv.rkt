#lang racket

(define (check-palindrome-partitioning-iv s)
  (define n (string-length s))

  ;; Constraints state 3 <= s.length <= 2000
  ;; So n will always be at least 3.

  ;; is-palindrome[i][j] stores whether s[i...j] is a palindrome
  ;; Using build-vector to create a vector of vectors
  (define is-palindrome (build-vector n (lambda (k) (make-vector n #f))))

  ;; Fill the DP table for palindromes
  ;; len is the length of the substring (1-indexed)
  (for ([len (in-range 1 (+ n 1))])
    (for ([i (in-range (- n len 0))]) ; i is the start index (0-indexed)
      (define j (+ i len -1)) ; j is the end index (0-indexed)

      (cond
        [(= len 1)
         ;; Single character substrings are always palindromes
         (vector-set! (vector-ref is-palindrome i) j #t)]
        [(= len 2)
         ;; Two character substrings are palindromes if their characters are the same
         (when (char=? (string-ref s i) (string-ref s j))
           (vector-set! (vector-ref is-palindrome i) j #t))]
        [else ; len > 2
         ;; Substrings of length > 2 are palindromes if outer characters match
         ;; and the inner substring is also a palindrome
         (when (and (char=? (string-ref s i) (string-ref s j))
                    (vector-ref (vector-ref is-palindrome (+ i 1)) (- j 1)))
           (vector-set! (vector-ref is-palindrome i) j #t))])))

  ;; Check for three partitions
  ;; We need to find two split points i and j such that:
  ;; 1. s[0...i] is a palindrome (first part)
  ;; 2. s[i+1...j] is a palindrome (second part)
  ;; 3. s[j+1...n-1] is a palindrome (third part)
  ;; All three parts must be non-empty.

  ;; i: end index of the first partition.
  ;;    It must be at least 0.
  ;;    It must leave at least two characters for the next two partitions, so i <= n-3.
  (for/first ([i (in-range (- n 2))] ; i goes from 0 to n-3
              ;; Check if the first partition s[0...i] is a palindrome
              #:when (vector-ref (vector-ref is-palindrome 0) i))
    ;; j: end index of the second partition.
    ;;    It must be at least i+1.
    ;;    It must leave at least one character for the third partition, so j <= n-2.
    (for/first ([j (in-range (+ i 1) (- n 1))] ; j goes from i+1 to n-2
                ;; Check if the second partition s[i+1...j] is a palindrome
                #:when (vector-ref (vector-ref is-palindrome (+ i 1)) j))
      ;; If we reach here, s[0...i] and s[i+1...j] are palindromes.
      ;; Now check the third partition s[j+1...n-1].
      ;; Since j <= n-2, j+1 <= n-1. So the third partition will always be non-empty.
      (when (vector-ref (vector-ref is-palindrome (+ j 1)) (- n 1))
        ;; If all three parts are palindromes, we found a valid partition.
        ;; for/first will return this value and exit.
        #t)))
  ;; If for/first completes without finding a #t, it returns #f.
  ;; The result of the outermost for/first is implicitly returned.
)