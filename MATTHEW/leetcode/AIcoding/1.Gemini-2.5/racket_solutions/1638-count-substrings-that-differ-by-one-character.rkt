#lang racket

(define (count-substrings s t)
  (let* ([len-s (string-length s)]
         [len-t (string-length t)]
         ; left[i][j] stores the length of the common prefix of s[i...] and t[j...]
         ; This is computed from bottom-right to top-left.
         ; Initialize with 0s.
         [left (make-vector len-s (lambda () (make-vector len-t 0)))]
         ; right[i][j] stores the length of the common suffix of s[...i] and t[...j]
         ; This is computed from top-left to bottom-right.
         ; Initialize with 0s.
         [right (make-vector len-s (lambda () (make-vector len-t 0)))]
         [total-count 0])

    ;; Compute left DP table
    ;; i from len-s-1 down to 0
    ;; j from len-t-1 down to 0
    (for ([i (in-range (sub1 len-s) -1 -1)])
      (for ([j (in-range (sub1 len-t) -1 -1)])
        (when (char=? (string-ref s i) (string-ref t j))
          (let ([next-val (if (and (< (add1 i) len-s) (< (add1 j) len-t))
                              (vector-ref (vector-ref left (add1 i)) (add1 j))
                              0)])
            (vector-set! (vector-ref left i) j (add1 next-val))))))

    ;; Compute right DP table
    ;; i from 0 to len-s-1
    ;; j from 0 to len-t-1
    (for ([i (in-range len-s)])
      (for ([j (in-range len-t)])
        (when (char=? (string-ref s i) (string-ref t j))
          (let ([prev-val (if (and (> i 0) (> j 0))
                              (vector-ref (vector-ref right (sub1 i)) (sub1 j))
                              0)])
            (vector-set! (vector-ref right i) j (add1 prev-val))))))

    ;; Calculate total count
    ;; For each pair (i, j) where s[i] != t[j], this (i, j) is the *single* differing character.
    ;; We count all substrings that have s[i] and t[j] as their only differing character.
    (for ([i (in-range len-s)])
      (for ([j (in-range len-t)])
        (when (not (char=? (string-ref s i) (string-ref t j)))
          (let ([l-match (if (and (> i 0) (> j 0))
                             (vector-ref (vector-ref right (sub1 i)) (sub1 j))
                             0)]
                [r-match (if (and (< (add1 i) len-s) (< (add1 j) len-t))
                             (vector-ref (vector-ref left (add1 i)) (add1 j))
                             0)])
            (set! total-count (+ total-count (* (add1 l-match) (add1 r-match))))))))
    total-count))