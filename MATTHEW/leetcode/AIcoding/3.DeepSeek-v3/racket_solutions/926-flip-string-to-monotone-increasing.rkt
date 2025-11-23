(define (min-flips-mono-incr s)
  (let loop ([i 0] [ones 0] [flips 0])
    (if (= i (string-length s))
        flips
        (let ([c (string-ref s i)])
          (if (char=? c #\1)
              (loop (add1 i) (add1 ones) flips)
              (loop (add1 i) ones (min (add1 flips) ones)))))))