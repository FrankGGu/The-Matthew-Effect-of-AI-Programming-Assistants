(define (reverse-bits n)
  (let loop ([n n] [result 0] [count 32])
    (if (= count 0)
        result
        (loop (arithmetic-shift n -1)
              (bitwise-ior (arithmetic-shift result 1) (bitwise-and n 1))
              (- count 1)))))