#lang racket

(define (get-is-palindrome-dp s n)
  (let ((dp (make-vector n #f)))
    (for ((i (range n)))
      (vector-set! dp i (make-vector n #f)))

    ;; Single characters are palindromes
    (for ((i (range n)))
      (vector-set! (vector-ref dp i) i #t))

    ;; Two characters
    (for ((i (range (- n 1))))
      (when (char=? (string-ref s i) (string-ref s (+ i 1)))
        (vector-set! (vector-ref dp i) (+ i 1) #t)))

    ;; Lengths > 2
    (for ((len (range 3 (+ n 1)))) ; len from 3 to n
      (for ((i (range (- n len -1)))) ; i from 0 to n-len
        (let ((j (+ i len -1))) ; j is end index
          (when (and (char=? (string-ref s i) (string-ref s j))
                     (vector-ref (vector-ref dp (+ i 1)) (- j 1)))
            (vector-set! (vector-ref dp i) j #t)))))
    dp))

(define (longest-palindrome-after-substring-concatenation-i s1 s2)
  (let* ((n (string-length s1))
         (max-len 0)
         (is-pal1 (get-is-palindrome-dp s1 n))
         (is-pal2 (get-is-palindrome-dp s2 n)))

    (define (calculate-max-len str1 str2 is-pal-str1 is-pal-str2)
      (let ((current-max 0))
        (for ((k (range (+ n 1)))) ; k is the length of the common prefix of str1 and reverse(str2)
          ;; Check if str1[0...k-1] matches reverse(str2[n-k...n-1])
          ;; i.e., str1[x] == str2[n-1-x] for 0 <= x < k
          (let loop-common ((x 0) (is-common #t))
            (if (or (not is-common) (>= x k))
                (when is-common
                  ;; If the first `k` characters match:
                  ;; A palindrome of length `2*k` is formed.
                  (set! current-max (max current-max (* 2 k)))

                  ;; Extend with longest palindrome in remaining part of str1: str1[k...n-1]
                  (for ((i_inner (range k n)))
                    (when (vector-ref (vector-ref is-pal-str1 k) i_inner)
                      (set! current-max (max current-max (+ (* 2 k) (- i_inner k -1)))))) ; length is i_inner - k + 1

                  ;; Extend with longest palindrome in remaining part of str2: str2[0...n-k-1]
                  (for ((j_inner (range (- n k))))
                    (when (vector-ref (vector-ref is-pal-str2 j_inner) (- n k 1))
                      (set! current-max (max current-max (+ (* 2 k) (- (- n k 1) j_inner -1)))))) ; length is (- n k 1) - j_inner + 1
                  )
                (if (char=? (string-ref str1 x) (string-ref str2 (- n 1 x)))
                    (loop-common (+ x 1) #t)
                    (loop-common (+ x 1) #f))))))
      current-max)

    ;; The problem specifies concatenating s1[0...i] with s2[j...n-1].
    ;; This means s1 acts as the "prefix string" and s2 acts as the "suffix string".
    ;; The `calculate-max-len` function correctly implements this logic.

    (set! max-len (calculate-max-len s1 s2 is-pal1 is-pal2))

    max-len))