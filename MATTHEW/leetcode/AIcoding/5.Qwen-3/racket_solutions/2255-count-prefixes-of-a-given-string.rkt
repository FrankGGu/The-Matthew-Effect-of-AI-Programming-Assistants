(define (prefix-count words s)
  (define len (string-length s))
  (define (count prefix)
    (if (>= (string-length prefix) len)
        0
        (if (equal? (substring s 0 (string-length prefix)) prefix)
            (+ 1 (count (cdr words)))
            (count (cdr words)))))
  (count words))