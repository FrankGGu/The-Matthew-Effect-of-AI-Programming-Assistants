(define (reverse-bits n)
  (let loop ((i 0) (result 0) (current-n n))
    (if (= i 32)
        result
        (loop (+ i 1)
              (bitwise-ior (arithmetic-shift result 1)
                           (bitwise-and current-n 1))
              (arithmetic-shift current-n -1)))))