(define (num-substrs s)
  (let loop ([i 0] [count 0] [prev -1])
    (if (= i (string-length s))
        count
        (let ([c (string-ref s i)])
          (if (char=? c #\1)
              (loop (+ i 1) (+ count (- i prev)) i)
              (loop (+ i 1) count i))))))