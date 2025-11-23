#lang racket

(define (is-anagram? s1 s2)
  (define (string->sorted-char-list s)
    (sort (string->list s) char<?))
  (equal? (string->sorted-char-list s1)
          (string->sorted-char-list s2)))

(define (minimum-length-of-anagram-concatenation s)
  (define s_len (string-length s))

  (for/first ([k (in-range 1 (add1 s_len))])
    (when (zero? (remainder s_len k))
      (define s_prefix (substring s 0 k))
      (define num_segments (/ s_len k))

      (define all-segments-are-anagrams?
        (for/all ([i (in-range 1 num_segments)])
          (define current_segment (substring s (* i k) (* (add1 i) k)))
          (is-anagram? s_prefix current_segment)))

      (when all-segments-are-anagrams?
        k))))