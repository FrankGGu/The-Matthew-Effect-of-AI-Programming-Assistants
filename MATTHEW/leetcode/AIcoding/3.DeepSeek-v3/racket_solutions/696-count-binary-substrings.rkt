(define (count-binary-substrings s)
  (let loop ((i 1) (prev 0) (curr 1) (result 0))
    (if (>= i (string-length s))
        result
        (if (char=? (string-ref s i) (string-ref s (- i 1)))
            (loop (+ i 1) prev (+ curr 1) result)
            (loop (+ i 1) curr 1 (+ result (min prev curr)))))))