(define (distinct-echo-substrings s)
  (define n (string-length s))
  (define substrings (hash-set))

  (for ([i (in-range n)])
    (for ([j (in-range (+ i 1 n))])
      (define sub (substring s i j))
      (define len (string-length sub))
      (when (and (> len 1) (<= (* 2 len) (- n i)))
        (define echo (substring s (+ i len) (+ i (* 2 len))))
        (when (equal? sub echo)
          (hash-set-add! substrings sub)))))

  (hash-set-count substrings))

(distinct-echo-substrings "abcabcabc") ; Call this function with your input