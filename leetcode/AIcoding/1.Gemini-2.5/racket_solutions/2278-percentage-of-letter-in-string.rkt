(define (percentage-of-letter s letter)
  (let* ((len (string-length s))
         (count (for/sum ((i (in-range len)))
                  (if (char=? (string-ref s i) letter)
                      1
                      0))))
    (floor (* 100.0 (/ count len)))))