(define (min-changes s)
  (let loop ((i 0) (count 0))
    (if (>= i (- (string-length s) 1))
        count
        (if (char=? (string-ref s i) (string-ref s (+ i 1)))
            (loop (+ i 2) (+ count 1))
            (loop (+ i 1) count)))))