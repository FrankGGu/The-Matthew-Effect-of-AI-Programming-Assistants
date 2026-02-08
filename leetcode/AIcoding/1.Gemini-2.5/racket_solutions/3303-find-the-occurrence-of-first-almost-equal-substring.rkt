(define (find-first-almost-equal-substring s1 s2 k)
  (let* ([len1 (string-length s1)]
         [len2 (string-length s2)])
    (for/first ([i (in-range 0 (- len1 len2 -1))] ; Iterate through all possible starting indices in s1
                #:when (let ([diff-count 0])
                         (for ([j (in-range len2)]) ; Compare the substring of s1 with s2
                           (when (not (char=? (string-ref s1 (+ i j)) (string-ref s2 j)))
                             (set! diff-count (+ diff-count 1))))
                         (<= diff-count k))) ; Check if the difference count is within k
      i ; Return the index i if a match is found
      #:else -1))) ; Return -1 if no such substring is found