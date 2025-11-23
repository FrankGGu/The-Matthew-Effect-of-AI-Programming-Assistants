#lang racket

(define (longestSubstring s k)
  (let ([n (string-length s)])
    (if (< n k)
        0 ; Base case: if string is shorter than k, no character can appear k times.
        (let* ([char->idx (lambda (c) (- (char->integer c) (char->integer #\a)))]
               [counts (make-vector 26 0)])
          ;; Populate character counts for the current string
          (for ([char (in-string s)])
            (vector-set! counts (char->idx char) (+ (vector-ref counts (char->idx char)) 1)))

          ;; Find the first character that appears less than k times
          (define (find-split-char)
            (for/first ([char (in-string s)]
                        #:when (< (vector-ref counts (char->idx char)) k))
              char))
          (let ([split-char (find-split-char)])
            (if (not split-char)
                ;; If no such character is found, it means all characters in the current string
                ;; appear at least k times. Thus, this entire string is a valid candidate.
                n
                ;; Otherwise, split the string by the 'bad' character and recurse on the parts.
                ;; The 'bad' character cannot be part of any valid substring.
                (let ([parts (string-split s (string split-char))])
                  (apply max (map (lambda (part) (longestSubstring part k)) parts)))))))))