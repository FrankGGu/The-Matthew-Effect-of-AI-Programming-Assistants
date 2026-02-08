(define (count-substrings s c)
  (let loop ((i 0) (count 0) (res 0))
    (if (>= i (string-length s))
        res
        (if (char=? (string-ref s i) c)
            (loop (+ i 1) (+ count 1) (+ res count 1))
            (loop (+ i 1) count res)))))