(define (reverse-bits n)
  (let loop ([n n] [result 0] [i 0])
    (if (= i 32)
        result
        (loop (arithmetic-shift n -1)
              (+ (arithmetic-shift result 1) (bitwise-and n 1))
              (+ i 1)))))