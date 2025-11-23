(define (min-flips-mono-incr s)
  (let loop ([i 0] [ones 0] [flips 0])
    (if (= i (string-length s))
        flips
        (let ([c (string-ref s i)])
          (if (char=? c #\1)
              (loop (+ i 1) (+ ones 1) flips)
              (loop (+ i 1) ones (min (+ flips 1) ones))))))))