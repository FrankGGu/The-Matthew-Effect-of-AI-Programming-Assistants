(define (count-substrings s c)
  (define (count-ends-with-char start end)
    (if (>= start end)
        0
        (+ 1 (count-ends-with-char start (+ end 1)))))
  (define (find-count idx)
    (if (>= idx (string-length s))
        0
        (+ (if (char=? (string-ref s idx) c)
               (count-ends-with-char idx idx)
               0)
           (find-count (+ idx 1)))))
  (find-count 0))